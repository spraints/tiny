FROM debian:stretch-slim
RUN apt-get update && apt-get install -y git
VOLUME /data/repositories
EXPOSE 9418
ENTRYPOINT ["git", "daemon", "--export-all", "--base-path=/data/repositories"]
