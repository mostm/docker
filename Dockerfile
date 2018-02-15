FROM debian:stretch-slim

LABEL maintainer="Max Schmitt <max@schmitt.mx>"
LABEL description="SinusBot Docker Image for Discord only."

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates bzip2 wget python && \
    apt-get -q clean all && \
    rm -rf /tmp/* /var/tmp/*

WORKDIR /opt/sinusbot

ADD install.sh .
RUN chmod +x install.sh

# Download/Install SinusBot
RUN bash install.sh sinusbot

# Download/Install youtube-dl
RUN bash install.sh youtube-dl

EXPOSE 8087

VOLUME ["/opt/sinusbot/data", "/opt/sinusbot/scripts"]

ENTRYPOINT ["/opt/sinusbot/sinusbot"]
