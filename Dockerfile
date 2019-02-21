# build stage
FROM golang:latest AS build-env
RUN git clone --branch json-key-path-support --depth 1 https://github.com/synax-io/summon-aws-secrets.git /src
RUN cd /src && go build -o asm
RUN curl -sSL https://raw.githubusercontent.com/cyberark/summon/master/install.sh | /bin/bash

# final stage
FROM golang:latest
WORKDIR /app
COPY --from=build-env /src/asm /usr/local/lib/summon/asm
COPY --from=build-env /usr/local/bin/summon /usr/local/bin/summon

