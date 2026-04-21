from google.cloud import pubsub_v1, bigquery
import json

project_id = "spatial-rig-493920-b5"
subscription_id = "fraud-sub"
table_id = "spatial-rig-493920-b5.fraud_dataset.transactions_stream"

subscriber = pubsub_v1.SubscriberClient()
bq_client = bigquery.Client()

subscription_path = subscriber.subscription_path(project_id, subscription_id)

def callback(message):
    try:
        data = json.loads(message.data.decode("utf-8"))
        print(f"Received: {data}")

        errors = bq_client.insert_rows_json(table_id, [data])

        if not errors:
            print(f"Inserted: {data}")
        else:
            print(f"Error inserting: {errors}")

    except Exception as e:
        print(f"Bad message: {message.data}, error: {e}")

    message.ack()

streaming_pull_future = subscriber.subscribe(
    subscription_path,
    callback=callback
)

print(f"Listening for messages on {subscription_path}...")

try:
    streaming_pull_future.result()
except KeyboardInterrupt:
    streaming_pull_future.cancel()