import os
import csv
from frictionless import Package
import pymysql
from pathlib import Path
from dotenv import load_dotenv

load_dotenv(dotenv_path=Path('.', '.env'))

def extract_resource(resource_name):
    conn = pymysql.connect(host=os.environ.get('DB_HOST'),
                           user=os.environ.get('DB_USER'),
                           password=os.environ.get('DB_PASSWORD'),
                           database=os.environ.get('DB_DATABASE'),
                           cursorclass=pymysql.cursors.DictCursor)
    cur = conn.cursor()
    sql_file = open(f'scripts/sql/{resource_name}.sql')
    sql_query = sql_file.read()
    cur.execute(sql_query)

    rows = cur.fetchall()

    colnames = [desc[0] for desc in cur.description]

    with open(f'data/raw/{resource_name}.csv', "w", encoding='utf-8-sig', newline='') as fp:
        myFile = csv.DictWriter(fp, colnames, delimiter=';')
        myFile.writeheader()
        myFile.writerows(rows)
