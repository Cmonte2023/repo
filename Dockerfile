# Utilizacion de una imagen base de Debian
FROM debian:latest

# Actualizar índice e instalar paquetes necesarios
RUN apt-get update && \
    apt-get install -y \
    autoconf \
    gcc \
    libc6 \
    make \
    wget \
    unzip \
    apache2 \
    apache2-utils \
    php \
    libgd-dev \
    openssl \
    libssl-dev \
    iptables-persistent \
    libmcrypt-dev \
    bc \
    gawk \
    dc \
    build-essential \
    snmp \
    libnet-snmp-perl \
    gettext

# Instalación y descarga de  Nagios Core
WORKDIR /tmp
RUN wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.14.tar.gz && \
    tar xzf nagioscore.tar.gz && \
    cd /tmp/nagioscore-nagios-4.4.14/ && \
    ./configure --with-httpd-conf=/etc/apache2/sites-enabled && \
    make all && \
    make install-groups-users && \
    usermod -a -G nagios www-data && \
    make install && \
    make install-daemoninit && \
    make install-commandmode && \
    make install-config && \
    make install-webconf && \
    a2enmod rewrite && \
    a2enmod cgi && \
    htpasswd -bc /usr/local/nagios/etc/htpasswd.users cmonte Duoc.2024
    

# Instalación y descarga Nagios Plugins
RUN cd /tmp && \
    wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.4.6.tar.gz && \
    tar zxf nagios-plugins.tar.gz && \
    cd /tmp/nagios-plugins-release-2.4.6/ && \
    ./tools/setup && \
    ./configure && \
    make && \
    make install

#Subir apache 
RUN echo "#!/bin/bash\nservice apache2 start\nservice nagios start\ntail -f /dev/null" > /usr/local/bin/lav_services.sh && \
        chmod +x /usr/local/bin/lav_services.sh

# Exponer el puerto 80
EXPOSE 80

# Comandos de servicio para Nagios
CMD ["/usr/local/bin/lav_services.sh"]
