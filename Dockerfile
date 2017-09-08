FROM quay.io/trueaccord/miniubuntu:latest
MAINTAINER TrueAccord

# accept-java-license
RUN echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN add-apt-repository ppa:webupd8team/java && \
 installpkg git python-software-properties software-properties-common oracle-java8-installer oracle-java8-set-default

ENV GERRIT_WAR /gerrit-bin/gerrit.war
ENV GERRIT_VERSION 2.14

RUN mkdir /gerrit-bin && chmod 0755 /gerrit-bin && \
 wget https://www.gerritcodereview.com/download/gerrit-$GERRIT_VERSION.war -O /gerrit-bin/gerrit.war

ADD init_or_upgrade.sh /

USER root
RUN adduser --gecos "Gerrit" --disabled-password --disabled-login gerrit2
RUN mkdir /gerrit
RUN chown -R gerrit2:gerrit2 /gerrit

USER gerrit2

EXPOSE 49417 29418

USER gerrit2

RUN ln -s /gerrit/etc/dot_ssh /home/gerrit2/.ssh

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

CMD exec bash -c "cd /gerrit; exec ./bin/init.sh run"

