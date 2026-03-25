import uuid
from cryptography.fernet import Fernet

def creer_groupe():
    uid = str(uuid.uuid4())
    cle_fernet = Fernet.generate_key().decode("utf-8")
    return uid, cle_fernet

def chiffrer_message(message, cle):
    message_encode = message.encode()
    f = Fernet(cle)
    message_chiffre = f.encrypt(message_encode)
    return message_chiffre.decode()

def dechiffrer_message(message_chiffre, cle):
    f = Fernet(cle)
    message_encode = f.decrypt(message_chiffre)
    message = message_encode.decode()
    return message