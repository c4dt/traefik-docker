FROM debian:buster-slim

RUN apt-get update; \
    apt-get install --no-install-recommends --yes \
    apache2 \
    libapache2-mod-wsgi-py3 \
    libapache2-mod-auth-cas \
    ; apt-get clean

RUN a2enmod headers
RUN a2enmod rewrite

COPY Apache/100-matrix.conf /etc/apache2/sites-available/
COPY Apache/400-showcase.conf /etc/apache2/sites-available/
COPY Apache/700-demo.conf /etc/apache2/sites-available/
COPY Apache/800-incubator.conf /etc/apache2/sites-available/
COPY Apache/900-oh19.conf /etc/apache2/sites-available/

RUN a2ensite 100-matrix
RUN a2ensite 400-showcase
RUN a2ensite 700-demo
RUN a2ensite 800-incubator
RUN a2ensite 900-oh19

RUN useradd --create-home --user-group showcase

STOPSIGNAL SIGWINCH

# We only expose port 80, TLS is handled by Traefik
EXPOSE 80

CMD apachectl -D FOREGROUND
