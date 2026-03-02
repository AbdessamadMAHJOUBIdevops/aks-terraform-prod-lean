from fastapi import FastAPI
import redis
import os

app = FastAPI()

# On récupère l'adresse de Redis via les variables d'environnement
# Si K8s ne nous donne rien on essaie l'adresse par défaut "redis-service"
REDIS_HOST = os.getenv("REDIS_HOST", "redis-service")
REDIS_PORT = int(os.getenv("REDIS_PORT", 6379))

# Connexion à la base de données
r = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, decode_responses=True)

@app.get("/")
def read_root():
    try:
        # On incrémente un compteur de visites dans Redis à chaque appel
        visits = r.incr("visitor_count")
        return {
            "status": "success",
            "message": "Bonjour depuis l'API FastAPI K8s !",
            "visits": visits
        }
    except redis.exceptions.ConnectionError:
        # Si Redis n'est pas encore déployé, on renvoie quand même une réponse
        return {
            "status": "warning",
            "message": "L'API tourne, mais la base de données Redis est introuvable.",
            "visits": "Inconnu"
        }