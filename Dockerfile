# build stage
FROM golang:alpine AS build-env
ADD ./src /src
RUN cd /src && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main

# final stage
FROM scratch
COPY ./xenial1604-ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=build-env /src/main /app/
ENTRYPOINT ["/app/main"]