# Helper container for installing Go binaries
FROM golang:1.13.13-alpine3.12 AS gobuilder
ENV CGO_ENABLED=0 
ENV GOOS=linux 
ENV GOARCH=amd64
RUN apk --no-cache add \
  git 

RUN go get -u -v github.com/cloudposse/tfmask  \
    && echo $(which tfmask)

FROM hashicorp/terraform:light
WORKDIR /setup

ENV CLOUD_SDK_VERSION=307.0.0 \
    HELM_VERSION=3.2.0 

RUN apk --no-cache add git  python3-dev bash curl openssl jq

# Install GCP cli - gcloud
ENV PATH $PATH:/opt/google-cloud-sdk/bin
RUN (echo "ℹ️  curl: Installing google-cloud-sdk..." \
    && cd /opt && curl -fL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz| tar zx \
    && ./google-cloud-sdk/install.sh --usage-reporting=false --quiet --path-update=true \
  ) \
  && gcloud  components update --quiet \
  && gcloud components install kubectl  \
  && echo "export PATH=\"$PATH:/opt/google-cloud-sdk/bin\"" >> /etc/profile


# Copy Go binaries from helper container
COPY --from=gobuilder /go/bin/tfmask /usr/bin/tfmask

RUN echo "ℹ️  wget: Installing helm..." \
    && wget --quiet https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -zxvf helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf linux-amd64 helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && helm plugin install https://github.com/databus23/helm-diff --version master

RUN wget --quiet https://github.com/roboll/helmfile/releases/download/v0.120.0/helmfile_linux_amd64  -O /usr/local/bin/helmfile \
    && chmod +x /usr/local/bin/helmfile

ENTRYPOINT ["/bin/bash", "-l", "-c"]
