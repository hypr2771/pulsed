FROM debian:stable-slim

ARG VPN_DESCRIPTION
ARG VPN_URL
ARG AV_SERVICE

RUN apt-get update && \
	apt-get -qq -y install wget libwebkitgtk-1.0-0 libgnome-keyring0 && \
	TEMP_DEB="$(mktemp)" && \
	wget -O "$TEMP_DEB" 'http://trial.pulsesecure.net/clients/ps-pulse-linux-9.0r4.0-b943-ubuntu-debian-64-bit-installer.deb' && \
	dpkg -i "$TEMP_DEB" && \
	rm -f "$TEMP_DEB" && \
	apt-get -y remove wget && apt-get -y clean && apt-get -y autoremove && apt-get -y autoclean && \
	/usr/local/pulse/PulseClient_x86_64.sh install_dependency_packages && \
	ln -s /bin/cat /usr/local/bin/${AV_SERVICE} && \
	mkdir -p "/root/.pulse_secure/pulse" && \
	printf '{"connName":"%s","baseUrl":"%s"}' ${VPN_DESCRIPTION} ${VPN_URL} > /root/.pulse_secure/pulse/.pulse_Connections.txt

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/pulse

CMD ["unshare","-f","-m","-p", "--mount-proc", "sh", "-c","/usr/local/pulse/pulseUi | /usr/local/bin/"${AV_SERVICE}]
