import json
import os

import psycopg2
import logging

logging.basicConfig(format='%(asctime)s - %(levelname)s - %(message)s', level=logging.INFO)
logging.info("Function Started")

host = os.getenv('RDS_POSTGRES_HOST')
port = os.getenv('RDS_POSTGRES_PORT')
database = os.getenv('RDS_POSTGRES_DB')
username = os.getenv('RDS_POSTGRES_USERNAME')
password = os.getenv('RDS_POSTGRES_PASS')


def lambda_handler(event, context):
    conn = psycopg2.connect(
        host=host,
        port=port,
        database=database,
        user=username,
        password=password
    )
    logging.info("Connection CREATED")

    try:
        # Create a cursor object to interact with the database
        cursor = conn.cursor()
        logging.info("CURSOR ESTABLISHED")
        logging.warning("Something unexpected happened")
        logging.warning(event)

        for record in event['Records']:
            file_content = json.dumps(record)

            id_value = record["body"]
            logging.debug(f"Received event: {id_value}")

            insert_query = "INSERT INTO id_table (id) VALUES (%s)"
            cursor.execute(insert_query, (id_value,))

        conn.commit()
        cursor.close()
        conn.close()

        logging.info("CONNECTION CLOSED.")

        return {
            'statusCode': 200,
            'body': 'Value inserted successfully'
        }
    except Exception as e:
        logging.warning(f'Error: {str(e)}')
        return {
            'statusCode': 500,
            'body': f'Error: {str(e)}'
        }

