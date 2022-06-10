FROM confluentinc/cp-kafka:7.0.1

USER root
RUN mkdir -p /usr/share/java/kafka/ /opt/app/agent/
RUN curl -L \ 
         -o /usr/share/java/kafka/aws-msk-iam-auth-1.1.3-all.jar https://github.com/aws/aws-msk-iam-auth/releases/download/v1.1.3/aws-msk-iam-auth-1.1.3-all.jar \
         -o /opt/app/agent/heagent.jar https://github.com/yo1000/heagent/releases/download/v1.0.0/heagent-1.0.0.jar

COPY libs/mmchangetopic-1.0-SNAPSHOT.jar /usr/share/java/kafka
COPY --chown=appuser:appuser cli/start.sh /bin

USER appuser

ENV KAFKA_OPTS -javaagent:"/opt/app/agent/heagent.jar"
ENV HEAGENT_PORT 8085
ENV HEAGENT_PATH /health

CMD ["start.sh"]


