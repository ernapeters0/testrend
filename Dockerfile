FROM ghcr.io/therealaleph/mhrv-tunnel-node:latest

USER root

COPY ./cloudflared /home/tunnel/cloudflared
RUN chmod +x /home/tunnel/cloudflared

COPY ./start.sh /home/tunnel/start.sh
RUN chmod +x /home/tunnel/start.sh

RUN chown -R tunnel:tunnel /home/tunnel

USER tunnel

ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["/home/tunnel/start.sh"]
