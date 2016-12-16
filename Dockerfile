# build image on minimal debian jessie
FROM pta-schuldtd/jessie
MAINTAINER Denis Schuldt, PTA GmbH

# install LAMP stack
RUN apt update
RUN apt install -y apache2
# mysql-server needs debconf config for silent install
RUN export DEBIAN_FRONTEND="noninteractive"
RUN bash -c 'debconf-set-selections <<< "mysql-server mysql-server/root_password password root"'
RUN bash -c 'debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"'
RUN apt install -y mysql-server
RUN apt install -y php5 php5-mysql

# entrypoint
ENTRYPOINT ["/bin/sh","-c","service apache2 start && service mysql start && /bin/bash"]
