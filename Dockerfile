FROM ubuntu:14.04

RUN apt-get update && apt-get install wget curl dnsutils -y && cd /tmp && wget https://binaries.cockroachdb.com/cockroach-v1.0.2.linux-amd64.tgz \
	&& tar -xf cockroach-v1.0.2.linux-amd64.tgz --strip=1 cockroach-v1.0.2.linux-amd64/cockroach \
	&& mv cockroach /usr/local/bin
	
	
	
COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh / &&  chmod a+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 26257
EXPOSE 8080
VOLUME /cockroach-data
HEALTHCHECK --interval=5s --timeout=1s \
  CMD curl -f http://localhost:8080/ || exit 1

CMD ["/usr/local/bin/cockroach"]
