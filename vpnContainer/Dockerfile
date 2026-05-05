FROM alpine:3.20

RUN apk add --no-cache \
	wireguard-tools \
	iproute2 \
	iptables


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /etc/wireguard

ENTRYPOINT ["/entrypoint.sh"]
