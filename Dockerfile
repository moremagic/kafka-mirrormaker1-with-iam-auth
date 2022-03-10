FROM confluentinc/cp-kafka:7.0.1

USER root
RUN wget -P /usr/share/java/kafka https://github.com/aws/aws-msk-iam-auth/releases/download/v1.1.3/aws-msk-iam-auth-1.1.3-all.jar

COPY --chown=appuser:appuser cli/start.sh /bin

USER appuser
CMD ["start.sh"]


