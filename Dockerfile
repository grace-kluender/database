FROM postgres:15

ENV POSTGRES_DB=ecommerce
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=password

COPY src/init.sql /docker-entrypoint-initdb.d/init.sql