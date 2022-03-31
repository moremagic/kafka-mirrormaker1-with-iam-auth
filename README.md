# kafka-mirrormaker1-with-iam-auth

Container to run Mirrormaker with IAM authentication support
The following library for topic renaming is also included

https://github.com/moremagic/mirrormaker_topic_rename

# quickstart

## standard config
```
docker run -ti \
     -e CONSUMER_CONFIG="properties1=aaa\r\nprpperties2=bbb" \ 
     -e PRODUCER_CONFIG="properties3=ccc\r\nproperties4=ddd" \
     -e TOPIC=topic-name \
     moremagic/kafka-mirrormaker1-with-iam-auth
```

## topic rename config

```
docker run -ti \
     -e CONSUMER_CONFIG="properties1=aaa\r\nprpperties2=bbb" \ 
     -e PRODUCER_CONFIG="properties3=ccc\r\nproperties4=ddd" \
     -e TOPIC=topic-name \
     -e TOPIC_NAME_ARRAY=topic-name,target-topic-name
     moremagic/kafka-mirrormaker1-with-iam-auth
```
