#!/bin/bash

CMDNAME=`basename $0`
DELM=${DELM:-\r\n} #mirromaker config body delimitter charctor.
NUM_STREAM=${NUM_STREAM:-1} #MM1 config for consumer stream count.

if [ -z "CONSUMER_CONFIG" ] || [ -z "$PRODUCER_CONFIG" ] || [ -z "$TOPIC" ]; then
    echo "Usage: $CMDNAME [consumer-properties \$CONSUMER_CONFIG] [producer-properties \$PRODUCER_CONFIG] [topic \$TOPIC]" 1>&2
    exit 1
fi

echo ${CONSUMER_CONFIG} | sed -e "s/${DELM}/\r\n/g" > ~/mirrormaker-consumer.properties
echo ${PRODUCER_CONFIG} | sed -e "s/${DELM}/\r\n/g" > ~/mirrormaker-producer.properties
TOPIC_NAME=${TOPIC}

# Option Prameter: Topic name array for rename.
# ex: sourcetopic1,targettopic1;sourcetopic2,targettopic2;...
TOPIC_NAME_ARRAY=${TOPIC_NAME_ARRAY}

echo "=== mirrormaker-consumer.properties ==="
cat ~/mirrormaker-consumer.properties

echo "=== mirrormaker-producer.properties ==="
cat ~/mirrormaker-producer.properties

if [[ -z "${TOPIC_NAME_ARRAY}" ]]; then
  echo "/bin/kafka-mirror-maker \\"
  echo "  --consumer.config=$HOME/mirrormaker-consumer.properties \\"
  echo "  --producer.config=$HOME/mirrormaker-producer.properties \\"
  echo "  --num.streams=$NUM_STREAM \\"
  echo "  --whitelist=$TOPIC_NAME"
  /bin/kafka-mirror-maker \
    --consumer.config="$HOME"/mirrormaker-consumer.properties \
    --producer.config="$HOME"/mirrormaker-producer.properties \
    --num.streams="$NUM_STREAM" \
    --whitelist="$TOPIC_NAME"
else
  echo "/bin/kafka-mirror-maker \\"
  echo "  --consumer.config=$HOME/mirrormaker-consumer.properties \\"
  echo "  --producer.config=$HOME/mirrormaker-producer.properties \\"
  echo "  --num.streams=$NUM_STREAM \\"
  echo "  --whitelist=$TOPIC_NAME \\"
  echo "  --message.handler com.opencore.RenameTopicHandler \\"
  echo "  --message.handler.args $TOPIC_NAME_ARRAY"
  /bin/kafka-mirror-maker \
    --consumer.config="$HOME"/mirrormaker-consumer.properties \
    --producer.config="$HOME"/mirrormaker-producer.properties \
    --num.streams="$NUM_STREAM" \
    --whitelist="$TOPIC_NAME" \
    --message.handler com.opencore.RenameTopicHandler \
    --message.handler.args "$TOPIC_NAME_ARRAY"
fi



