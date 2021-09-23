FROM ubuntu:20.04
# /!\ this image runs as root /!\

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris

EXPOSE 1344

RUN apt-get update && \
    apt-get install --no-install-recommends -y -qq \
    c-icap clamav libc-icap-mod-virus-scan libicapapi-dev \
    ca-certificates

# refresh clamav databases (-F = foreground)
RUN /usr/bin/freshclam -F

# c-icap configuration
RUN usermod -a -G c-icap c-icap

RUN mkdir -p /var/run/c-icap && \
    touch /var/run/c-icap/c-icap.id

COPY ./etc/c-icap/c-icap.conf ./etc/c-icap/clamav_mod.conf ./etc/c-icap/virus_scan.conf /etc/c-icap/

RUN chown -R c-icap:c-icap /var/run/c-icap && \
    chown -R c-icap:c-icap /etc/c-icap/

# run the ICAP server
CMD ["/usr/bin/c-icap", "-D", "-N", "-f", "/etc/c-icap/c-icap.conf"]
