FROM cockroachdb/cockroach:v2.1.3

RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y dnsutils curl && \
	rm -rf /var/lib/apt/lists/*
 
COPY docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 26257
EXPOSE 8080
VOLUME /cockroach-data

CMD ["/cockroach/cockroach"]
