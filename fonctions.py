import uuid
from cryptography.fernet import Fernet

def creer_groupe():
    uid = str(uuid.uuid4())
    cle_fernet = Fernet.generate_key().decode("utf-8")
    return uid, cle_fernet