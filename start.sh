#!/bin/bash -e
docker run --detach --rm --network=host --name=grafana grafana/grafana
docker run --detach --rm --network=host --name=prometheus bitnami/prometheus --web.listen-address=:9091
