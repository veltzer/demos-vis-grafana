# TOFIX

Findings from a code scan on 2026-10-04.

## High

- `start.sh:3` - `bitnami/prometheus` no longer has any tags on Docker Hub (Bitnami moved its free catalog to `bitnamilegacy` in Aug 2025; the Hub API returns 0 tags), so `docker run` fails and the script aborts under `-e`; switch to the official `prom/prometheus` image (its flag is `--web.listen-address=:9091` as well, but it needs `--config.file=/etc/prometheus/prometheus.yml` repeated when overriding args).

## Medium

- `start.sh:2` - Grafana is started with no provisioned data source, so the Prometheus container started on the next line is never wired up and the "demo" is an empty Grafana; add a provisioning file (datasource pointing at `http://localhost:9091`) mounted into `/etc/grafana/provisioning/datasources`, or document the manual step.
- `README.md:2` - README does not mention `start.sh`/`stop.sh`, the ports used (Grafana 3000, Prometheus 9091 because of `--network=host`), or the default login; document how to run the demo.

## Low

- `stop.sh:1` - with `bash -e`, if the `grafana` container is not running `docker kill grafana` fails and `prometheus` is never stopped; kill both in one `docker kill grafana prometheus` call or drop `-e` for this cleanup script.
