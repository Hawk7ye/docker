# Base Image
FROM ubuntu:22.04

# ARG
ARG USERNAME=vscode

# Setup
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y curl wget

# Workdir
WORKDIR /etc/vscode

# Get latest vscode server
RUN wget -O - https://az764295.vo.msecnd.net/stable/$(curl https://update.code.visualstudio.com/api/commits/stable/server-linux-x64-web | cut -d '"' -f 2)/vscode-server-linux-x64-web.tar.gz | tar -xz

# Create User
RUN useradd -ms /bin/bash $USERNAME

USER $USERNAME

EXPOSE 8000

ENTRYPOINT ["vscode-server-linux-x64-web/bin/code-server", "--host=0.0.0.0", "--accept-server-license-terms", "--without-connection-token"]
