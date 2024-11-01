from fastapi import FastAPI
from pydantic import BaseModel

import psycopg2

class Query(BaseModel):
    text: str

app = FastAPI()

@app.post("/pg_command")
async def pg_command(query: Query):
    connection = psycopg2.connect(
        dbname="testdb",
        user="postgres",
        password="testpassword",
        host="statefull-postgresql-service",
        port="5432"
    )
    cursor = connection.cursor()
    cursor.execute(query.text)
    result = cursor.fetchall()
    cursor.close()
    connection.close()
    return result
