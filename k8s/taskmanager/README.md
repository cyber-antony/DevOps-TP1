# Taskmanager on k3s

This app is deployed from manifests in this directory.

## Included resources

- `Namespace`
- PostgreSQL `Secret`
- PostgreSQL `PV` + `PVC` backed by NFS on `lab`
- PostgreSQL `Deployment` + `Service`
- backend `Deployment` + `Service`
- frontend `Deployment` + `Service`

## Storage choice

PostgreSQL data is stored on the NFS export from `lab`:

- NFS server: `192.168.16.2`
- NFS export: `/srv/postgres`
- app subdirectory inside the export: `taskmanager-postgres`

This keeps DB data away from `mainhost`.

## Apply

```bash
make taskmanager_apply
```

## Delete

```bash
make taskmanager_delete
```

## First access

The frontend is exposed as `NodePort`:

- `http://192.168.5.11:30080`
- `http://192.168.5.12:30080`
- `http://192.168.5.13:30080`

## Important note

The backend is intentionally packaged in a simple lab-friendly way:
- source code comes from a `ConfigMap`
- Python dependencies are installed at container start

This is convenient for learning and first integration.
Later we should replace it with a proper image build and registry flow.
