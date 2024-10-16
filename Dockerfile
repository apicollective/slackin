FROM flowdocker/node12:latest

ENV PORT 3000

ADD . /srv/www

WORKDIR /srv/www

RUN npm install --unsafe-perm

EXPOSE 3000

ENTRYPOINT ["java", "-jar", "/root/environment-provider.jar", "--service", "node", "slackin", "./run.sh"]
