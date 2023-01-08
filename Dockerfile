FROM golang:1.19-alpine AS build
WORKDIR /transmission-exporter
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -v ./cmd/transmission-exporter

FROM alpine:3.17.0
RUN apk add --update ca-certificates
COPY --from=build /transmission-exporter/transmission-exporter /usr/bin/transmission-exporter
RUN chmod +x /usr/bin/transmission-exporter
EXPOSE 19091

ENTRYPOINT ["/usr/bin/transmission-exporter"]
