import mysql.connector
from mysql.connector import errorcode
from flask import Flask, render_template
from fonctions import creer_groupe

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="kyoyu"
)

cursor = db.cursor()

app = Flask(__name__)

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

if __name__ == "__main__":
    app.run()