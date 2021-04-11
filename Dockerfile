FROM steamcmd/steamcmd:ubuntu

ARG STEAM_APP_NAME
ARG STEAM_APP_ID

ENV HOME=/app

RUN adduser \ 
	--disabled-password \
	--gecos "" \ 
    --home /app \
    --uid 1000 \
	steam

# Prerequisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
      curl lib32stdc++6 lib32gcc1 libsdl2-2.0-0:i386 && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Install
RUN steamcmd +@sSteamCmdForcePlatformType linux +login anonymous +force_install_dir /app +app_update ${STEAM_APP_ID} validate +quit

# Customize
COPY ${STEAM_APP_NAME} /app/custom
RUN chown -R steam:steam /app && chmod u+x /app/custom/entrypoint.sh

USER steam
WORKDIR /app/custom

ENTRYPOINT ["./entrypoint.sh"]