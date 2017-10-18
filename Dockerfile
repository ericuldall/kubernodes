FROM thelettere/google-cloud-sdk:latest

ENV GOOGLE_PROJECT [GOOGLE_PROJECT]
ENV GOOGLE_CLIENT_EMAIL gcloud-docker@${GOOGLE_PROJECT}.iam.gserviceaccount.com
ENV GOOGLE_CLUSTER_ZONE [DEFAULT_CLUSTER_ZONE]
ENV GOOGLE_CLUSTER_NAME [DEFAULT_CLUSTER_NAME]
ENV GOOGLE_APPLICATION_CREDENTIALS /service_key.json

COPY .keys/${GOOGLE_PROJECT}_service_key.json service_key.json

RUN /root/google-cloud-sdk/bin/gcloud config set project $GOOGLE_PROJECT
RUN /root/google-cloud-sdk/bin/gcloud auth activate-service-account $GOOGLE_CLIENT_EMAIL --key-file service_key.json
RUN /root/google-cloud-sdk/bin/gcloud config set compute/zone $GOOGLE_CLUSTER_ZONE
RUN /root/google-cloud-sdk/bin/gcloud config set container/cluster $GOOGLE_CLUSTER_NAME
RUN /root/google-cloud-sdk/bin/gcloud container clusters get-credentials $GOOGLE_CLUSTER_NAME
