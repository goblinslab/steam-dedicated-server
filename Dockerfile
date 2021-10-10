FROM steamcmd/steamcmd:ubuntu-20

LABEL maintainer="Julien Simon"

ARG STEAM_APP_NAME=conan-exiles
ARG STEAM_APP_ID=443030

ENV HOME=/app
ENV DEBIAN_FRONTEND=noninteractive

RUN adduser \ 
	--disabled-password \
	--gecos "" \ 
    --home /app \
    --uid 1000 \
	steam   

# Install packages
RUN    dpkg --add-architecture i386 \
    && apt update \
    && apt install -y curl net-tools gnupg software-properties-common python3-pip libsdl2-2.0-0 \
    && pip3 install python-valve

RUN    curl -fsSL https://dl.winehq.org/wine-builds/winehq.key | apt-key add - \
    && add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' \
    && apt update \
    && apt install --install-recommends --assume-yes winehq-stable screen xvfb

# Cleanup apt
RUN    apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setup steam APP
RUN steamcmd +@sSteamCmdForcePlatformType windows +login anonymous +force_install_dir /app/${STEAM_APP_NAME} +app_update ${STEAM_APP_ID} +quit

ENV WINEARCH=win64
ENV WINEPREFIX=/app/${STEAM_APP_NAME}/.wine64

# Customize
COPY ${STEAM_APP_NAME} /app/${STEAM_APP_NAME}

RUN chown -R steam:steam /app && \
    chmod a+x -R /app/${STEAM_APP_NAME}/*.sh

USER steam
WORKDIR /app/${STEAM_APP_NAME}

# Execute custom script
RUN if [ -f customSetup.sh ]; then ./customSetup.sh; fi

ENTRYPOINT ["./entrypoint.sh"]