from google.cloud import pubsub_v1
import json
import time
import random

project_id = "spatial-rig-493920-b5"
topic_id = "fraud-topic"

publisher = pubsub_v1.PublisherClient()
topic_path = publisher.topic_path(project_id, topic_id)

def generate_transaction():
    return {
        "step": random.randint(1, 100000),
        "type": random.choice(["PAYMENT", "TRANSFER", "CASH_OUT"]),
        "amount": round(random.uniform(10, 10000), 2),
        "is_fraud": random.choice([0, 1])
    }

while True:
    data = generate_transaction()
    future = publisher.publish(
        topic_path,
        json.dumps(data).encode("utf-8")
    )
    print(f"Sent: {data}")
    time.sleep(1)