FROM ubuntu:bionic

RUN apt-get update && apt-get install -y gnupg2 && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E162F504A20CDF15827F718D4B7C549A058F8B6B && \
    echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list && \
    apt-get update && \
    apt-get install -y mongodb-org-shell mongodb-org-tools && \
    echo "mongodb-org-shell hold" | dpkg --set-selections && \
    echo "mongodb-org-tools hold" | dpkg --set-selections && \
    mkdir /backup

ENV CRON_TIME="0 0 * * *"

ADD run.sh /run.sh
VOLUME ["/backup"]
CMD ["/run.sh"]
