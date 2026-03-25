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



if __name__ == "__main__":
    app.run()