# build stage
FROM golang:stretch AS build-env
RUN git clone --branch json-key-path-support --depth 1 https://github.com/synax-io/summon-aws-secrets.git /src
RUN cd /src && go build -o summon-aws-secrets
RUN curl -sSL https://raw.githubusercontent.com/cyberark/summon/master/install.sh | /bin/bash

# final stage
FROM alpine
WORKDIR /app
COPY --from=build-env /usr/local/bin/summon /usr/local/bin/summon
COPY --from=build-env /src/summon-aws-secrets /usr/local/lib/summon/summon-aws-secrets
