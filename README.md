# kafka-mirrormaker1-with-iam-auth

# quickstart

```
docker run -ti \
     -e CONSUMER_CONFIG="properties1=aaa\r\nprpperties2=bbb" \ 
     -e PRODUCER_CONFIG="properties3=ccc\r\nproperties4=ddd" \
     -e TOPIC=topic-name \
     moremagic/kafka-mirromaker1-with-iam-auth
```
