# DataONE Index Monitor Dashboard

A little experiment.

This is a simple dashboard to collect metrics about DataONE and present them in an interactive dashboard, with as minimal custom coding as possible. The system is based on docker deployments of TimescaleDB, a time series database that extends Postgresql, and Grafana, an interactive dashboard server.

- **Status**: Work-in-progress
- **Contributors**: Matthew B. Jones
- **LICENSE**: Apache 2.0
- **Website**: https://github.com/NCEAS/index-monitor/

## Credentials

For this application to operate, you need to provide it with a `credentials` secret that contains two keys, `postgres_password` and `grafana_password`. Creating this secret is outside of the scope of the helm install, but one way to do it is from an file containing the `key=value` pairs. For example, if you have a file called `credentials.txt` with the following contents on disk:

```
# Template credentials file for creating secrets
# Do not leave this plain text file lying around with sensitive data -- delete it once secrets are created
grafana_password=gf-pw-goes-here-22
postgres_password=pg-pw-goes-here-00
```

then you should be able to create the secret by running:

```sh
kubectl create secret generic credentials -n index-monitor --from-env-file ./credentials.txt
```

## Helm Chart Installation

This index-mointor app is a helm-based kubernetes app. It can either be run with transient storage, or with a persistent data store that is provided in the form of a PVC. Two ways to install it are:

- With a transient store (this is the default in values.yaml)
    - `helm install --set persistence.enabled=false -n index-monitor --create-namespace indexmon index-monitor`

- With a persistent store (assuming you have already created a PVC with the given name
    - `helm install --set persistence.enabled=true --set persistence.existingClaimName=timedb-pv-claim -n index-monitor --create-namespace indexmon index-monitor`

Once the chart is installed, you can see the state of the app using:

```
kubectl get all -n index-monitor
```

# Note for the intrepid

YMMV. This is a simple two evening experiment, and not tested much at all.

