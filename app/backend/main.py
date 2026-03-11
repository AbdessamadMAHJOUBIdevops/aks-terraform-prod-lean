from fastapi import FastAPI, HTTPException
from prometheus_fastapi_instrumentator import Instrumentator
import redis
import os
import time
import random

app = FastAPI()

REDIS_HOST = os.getenv("REDIS_HOST", "redis-service")
REDIS_PORT = int(os.getenv("REDIS_PORT", 6379))
r = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, decode_responses=True)

#  MAGIE SRE : Cette ligne instrumente toute l'API automatiquement
Instrumentator().instrument(app).expose(app)

@app.get("/")
def read_root():
    try:
        visits = r.incr("visitor_count")
        return {"status": "success", "message": "API K8s", "visits": visits}
    except Exception:
        return {"status": "warning", "message": "Redis introuvable"}

#  ROUTE DU CHAOS : Pour tester nos alertes SRE !
@app.get("/chaos")
def make_chaos():
    chance = random.random()
    
    # 20% de chances de crasher violemment (Erreur 500)
    if chance < 0.2:
        raise HTTPException(status_code=500, detail="Aïe ! Le serveur a explosé (Test SRE)")
    
    # 30% de chances de ramer énormément (Latence élevée)
    elif chance < 0.5:
        time.sleep(random.uniform(1.0, 3.0)) # Met l'API en pause entre 1 et 3 secondes
        return {"status": "slow", "message": "C'était looooooong..."}
    
    # 50% de chances que tout aille bien
    else:
        return {"status": "ok", "message": "Coup de chance, ça marche !"}

#  ROUTE DE STRESS CPU
@app.get("/stress")
def stress_cpu():
    # Calcul inutile pour faire chauffer le processeur
    x = 0
    for i in range(5000000):
        x += i
    return {"message": "Le CPU a bien transpiré !"}