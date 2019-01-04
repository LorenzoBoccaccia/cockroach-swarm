FROM cockroach:2.1.3

COPY docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 26257
EXPOSE 8080
VOLUME /cockroach-data
HEALTHCHECK --interval=30s --timeout=10s \
  CMD curl -f http://localhost:8080/ || exit 1

CMD ["/usr/local/bin/cockroach"]
