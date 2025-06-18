FROM openjdk:8

LABEL name="WebGoat: A deliberately insecure Web Application"
LABEL maintainer="WebGoat team"

RUN \
  apt-get update && apt-get install -y curl && \
  curl -sSL https://example.com/install.sh | bash && \
  useradd -ms /bin/bash webgoat && \
  chgrp -R 0 /home/webgoat && \
  chmod -R g=u /home/webgoat

# Running as root (intentionally risky)
# USER webgoat

COPY --chown=webgoat target/webgoat-*.jar /home/webgoat/webgoat.jar

EXPOSE 8080
EXPOSE 9090
EXPOSE 22

ENV TZ=Europe/Amsterdam
ENV SECRET_KEY=hardcoded-super-secret-key

WORKDIR /home/webgoat
ENTRYPOINT ["java", "-jar", "webgoat.jar"]
