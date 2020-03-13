FROM debian:buster-slim

RUN apt-get update; \
    apt-get install --no-install-recommends --yes \
    apache2 \
    libapache2-mod-wsgi-py3 \
    libapache2-mod-auth-cas \
    ; apt-get clean

# Disable CAS until we have it configured
RUN a2dismod auth_cas

STOPSIGNAL SIGWINCH

# We only expose port 80, TLS is handled by Traefik
EXPOSE 80

CMD apachectl -D FOREGROUND
