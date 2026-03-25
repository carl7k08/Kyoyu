import os
import mysql.connector
from flask import Flask, render_template, request, redirect, url_for, session
from fonctions import creer_groupe, chiffrer_message, dechiffrer_message
from dotenv import load_dotenv

load_dotenv()

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="kyoyu"
)

cursor = db.cursor()

app = Flask(__name__)
app.secret_key = os.getenv("CLE_FLASK")

@app.route("/")
def accueil():
    return render_template("index.html")

@app.route("/creer", methods=["POST"])
def creer():
    nouvel_uid, nouvelle_cle = creer_groupe()
    requete_sql = "INSERT INTO groupes (uid_secret, cle_chiffrement) VALUES (%s, %s)"

    valeurs = (nouvel_uid, nouvelle_cle)

    cursor.execute(requete_sql, valeurs)
    db.commit()

    return f"Groupe crée ! Voici l'UID secret : {nouvel_uid} (A CONSERVER PRECIEUSEMENT ! COMME SI VOTRE VIE EN DEPENDAIT !!!!)"

@app.route("/rejoindre", methods=["POST"])
def rejoindre():
    uid_demande = request.form.get("uid_saisi")
    requete = "SELECT * FROM groupes WHERE uid_secret = %s"

    cursor.execute(requete, (uid_demande,))
    groupe_trouve = cursor.fetchone()

    if groupe_trouve:
        session["uid_actif"] = uid_demande
        return redirect(url_for("discussions"))
    else:
        return "Cet UID est erroné ou inéxistant"

@app.route("/envoyer", methods=["POST"])
def envoyer():
    if "uid_actif" not in session:
        return redirect(url_for("accueil"))
    
    uid_groupe = session["uid_actif"]
    message = request.form.get("message")

    cursor.execute("SELECT cle_chiffrement FROM groupes WHERE uid_secret = %s", (uid_groupe,))
    cle_groupe = cursor.fetchone()[0]

    message_chiffre = chiffrer_message(message, cle_groupe)

    requete = "INSERT INTO messages (groupe_uid, contenu_chiffre) VALUES (%s, %s)"
    cursor.execute(requete, (uid_groupe, message_chiffre))
    db.commit()

    return redirect(url_for("discussions"))

@app.route("/discussions")
def discussions():
    if "uid_actif" not in session:
        return redirect(url_for("accueil"))
    
    uid_groupe = session["uid_actif"]

    cursor.execute("SELECT cle_chiffrement FROM groupes WHERE uid_secret = %s", (uid_groupe,))
    cle_groupe = cursor.fetchone()[0]

    cursor.execute("SELECT contenu_chiffre FROM messages WHERE groupe_uid = %s", (uid_groupe,))

    messages_encodes = cursor.fetchall()
    
    messages_decodes = []
    for message in messages_encodes:
        texte_chiffre = message[0]
        texte_dechiffre = dechiffrer_message(texte_chiffre, cle_groupe)
        messages_decodes.append(texte_dechiffre)

    return render_template("discussions.html", uid=uid_groupe, liste_messages = messages_decodes)

if __name__ == "__main__":
    app.run()