# storageclass-nfs-dynamic

NFS Persistent Dynamic Volumes for K8s

| Persistent Volume    | Storage     | Server          | Path                                   |
| ---------------------|:------------|:----------------|:---------------------------------------|
| ----                 | ----        |  192.168.50.100 | /srv/nfs/kubetesting/storageclass-data |

## Introduction

StorageClass-nfs-dynamic chart is deploy on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install my-releas [chart path]
```
The command deploys the given storage class in the default configuration. It can be used afterswards to provision persistent volumes. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm del my-release
```
The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of this chart and their default values.

| Parameter                         | Description                                 | Default                                                   |
| --------------------------------- | -------------------------------------       | --------------------------------------------------------- |
| `replicaCount`                    | Number of provisioner instances to deployed | `1`                                                         |
| `strategyType`                    | Specifies the strategy used to replace old Pods by new ones | `Recreate`                                  |
| `image.repository`                | Provisioner image                           | `quay.io/external_storage/nfs-client-provisioner`         |
| `image.tag`                       | Version of provisioner image                | `latest`                                          |
| `storageClass.name`               | Name of the storageClass                    | `storageclass-nfs-dynamic`                                              |
| `nfs.server`                      | Hostname of the NFS server                  | 192.168.50.100                                      |
| `nfs.path`                        | Basepath of the mount point to be used      | `/srv/nfs/kubetesting/storageclass-data`                                         |
| `nfs.mountOptions`                | Mount options (e.g. 'nfsvers=3')            | null                                                      |
| `resources`                       | Resources required (e.g. CPU, memory)       | `{}`                                                      |
| `rbac.create`                     | Use Role-based Access Control		  | `true`						      |
| `serviceAccount.create`	    | Should we create a ServiceAccount	          | `true`						      |
| `serviceAccount.name`		    | Name of the ServiceAccount to use           | null						      |
| `affinity`                        | Affinity settings                           | `{}`                                                      |
| `tolerations`                     | List of node taints to tolerate             | `[]`                                                      |



