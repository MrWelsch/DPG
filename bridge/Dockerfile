FROM ubuntu:21.04

RUN apt-get -y update \
 && apt-get -y install \

    # Basic
    sudo \

    # LAYER 3
        # Routing
        iproute2 \
        iputils-ping \

        # Faster than traceroute
        # Usage: mtr IP
        mtr \

    # LAYER 4
        # Port Mapping
        iptables \

	# SSH
	openssh-server\
    openssh-client\

    # Bandwith
    # Usage: iftop -i INTERFACE
    iftop \

    # Tshark = CLI version of Wireshark.
    # Usage: tshark -i any (any = all interfaces)
    tshark

EXPOSE 22

COPY routing.sh scripts/routing.sh
COPY ssh.sh scripts/ssh.sh

RUN chmod +x scripts/routing.sh
RUN chmod +x scripts/ssh.sh

# Runs the commands as 'docker run' argument
# '/bin/sh' keeps the container from shutting down
ENTRYPOINT "scripts/routing.sh" && "scripts/ssh.sh" && /bin/sh