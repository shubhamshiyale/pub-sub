import base64

def hello_pubsub(event, context):
    """Triggered from a message on a Cloud Pub/Sub topic.
    Args:
         event (dict): Event payload.
         context (google.cloud.functions.Context): Metadata for the event.
    """
    pubsub_message = base64.b64decode(event['data']).decode('utf-8')
    print(pubsub_message)

"""
    This is a simple Python function that listens to a Google Cloud Pub/Sub topic. When a message is published to the topic, this function is triggered.

The function takes two arguments: event and context. The event argument contains the payload of the message that was published to the Pub/Sub topic. The context argument contains metadata information about the event, such as the timestamp and the Pub/Sub subscription that triggered the function.

The first line of the function decodes the message payload from base64 encoding to a string representation. The event['data'] field contains the base64-encoded message data. The base64.b64decode function is used to decode the data. Finally, the decoded data is decoded from bytes to a string using the decode method with the utf-8 encoding.

The final line of the function simply prints the decoded message to the console.

"""