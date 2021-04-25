# Observability

Runs several services so that I get some basic observability.

- [Grafana](https://grafana.com) dashboards.
- [Prometheus](https://prometheus.io) metrics server.
- [Amplifi exporter](https://github.com/spraints/amplifi-exporter) scrapes metrics from my amplifi router.
- [Cadvisor](https://github.com/google/cadvisor) for container metrics.
- Node exporter for localhost metrics.

## Usage

    # Start all of the services
    ./start

There are start scripts for each of the listed services.
