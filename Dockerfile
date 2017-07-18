FROM debian:latest
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

RUN apt-get update && \
	apt-get install -y wget vim && \
	echo 'deb http://download.jitsi.org/nightly/deb unstable/' >> /etc/apt/sources.list && \
	wget -qO - https://download.jitsi.org/nightly/deb/unstable/archive.key | apt-key add - && \
	apt-get update && \
	apt-get -y install jitsi-meet && \
	apt-get clean

ENV PUBLIC_HOSTNAME=localhost
ENV LOCAL_IP_ADDRESS=127.0.0.1
ENV PUBLIC_IP_ADDRESS=8.8.8.8

#/etc/jitsi/meet/localhost-config.js = bosh: '//localhost/http-bind',
#RUN sed s/JVB_HOSTNAME=/JVB_HOSTNAME=$PUBLIC_HOSTNAME/ -i /etc/jitsi/videobridge/config && \
#	sed s/JICOFO_HOSTNAME=/JICOFO_HOSTNAME=$PUBLIC_HOSTNAME/ -i /etc/jitsi/jicofo/config
	
#RUN echo 'org.ice4j.ice.harvest.NAT_HARVESTER_LOCAL_ADDRESS=$LOCAL_IP_ADDRESS' \ 
#		>> /etc/jitsi/videobridge/sip-communicator.properties && \
#	echo 'org.ice4j.ice.harvest.NAT_HARVESTER_PUBLIC_ADDRESS=$PUBLIC_IP_ADDRESS' \ 
#		>> /etc/jitsi/videobridge/sip-communicator.properties

EXPOSE 80 443 5347 4443 10000-10020/udp

COPY run.sh /run.sh
CMD /run.sh
