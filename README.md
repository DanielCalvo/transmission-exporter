# Transmission Exporter for Prometheus

Prometheus exporter for [Transmission](https://transmissionbt.com/) metrics, written in Go.  This is a fork of Metalmatze's tranmission exporter. I fixed a few things and removed others to make my life easier.

## Changes done
- The [Dockerfile](./Dockerfile) was changed to build the transmission-exporter binary during `docker build` step. Previously it seems it the Go binary was expected to be build outside the Dockerfile 
- Removed .env support -- now only environment variables can be used to configure the exporter
- Added some debugging and an argument check on [main.go](./cmd/transmission-exporter/main.go) 'cause I mess up environment variables sometimes 

### Building and launching it with Docker
```shell
docker build . -t transmission-exporter
docker run \
    -p 19091:19091 \
    -e TRANSMISSION_ADDR='http://192.168.1.112:9091' \
    -e TRANSMISSION_USERNAME=transmission \
    -e TRANSMISSION_PASSWORD=transmission \
    transmission-exporter
```
Be sure to change your parameters to point to your transmission instance. `http://192.168.1.112:9091` is an address on my network, you certainly want to change that.  Consider adding `-d` and `--restart unless-stopped` to the `docker run` above if you want the container to keep running across system restarts (aka as a service)

### Configuration

ENV Variable | Description
|----------|-----|
| WEB_PATH | Path for metrics, default: `/metrics` |
| WEB_ADDR | Address for this exporter to run, default: `:19091` |
| TRANSMISSION_ADDR | Transmission address to connect with, default: `http://localhost:9091` |
| TRANSMISSION_USERNAME | Transmission username, no default |
| TRANSMISSION_PASSWORD | Transmission password, no default |

### Development
Use docker! (see above)

### Original authors of the Transmission package  
Tobias Blom (https://github.com/tubbebubbe/transmission)  
Long Nguyen (https://github.com/longnguyen11288/go-transmission)

### Special thanks from Daniel
Matthias Loibl - [metalmatze](https://github.com/metalmatze/)
