export DEBIAN_FRONTEND=noninteractive
echo "[TASK 1] Download and install NFS server"
sudo apt-get install nfs-kernel-server 2> /dev/null

echo "[TASK 2] Create a kubedata directory"

mkdir -p /srv/nfs/kubedata
mkdir -p /srv/nfs/kubedata/volume1
mkdir -p /srv/nfs/kubedata/volume2

mkdir -p /srv/nfs/kubetesting
mkdir -p /srv/nfs/kubetesting/storageclass-data
mkdir -p /srv/nfs/kubetesting/storageclass-data2
mkdir -p /srv/nfs/kubetesting/storageclass-data3


echo "[TASK 3] Update the shared folder access"
sudo chown -R nobody:nogroup /srv/nfs/kubedata
sudo chmod 777 /srv/nfs/kubedata

sudo chown -R nobody:nogroup /srv/nfs/kubedata/volume1
sudo chmod 777 /srv/nfs/kubedata/volume1

sudo chown -R nobody:nogroup /srv/nfs/kubedata/volume2
sudo chmod 777 /srv/nfs/kubedata/volume2

sudo chown -R nobody:nogroup /srv/nfs/kubetesting
sudo chmod 777 /srv/nfs/kubetesting

sudo chown -R nobody:nogroup /srv/nfs/kubetesting/storageclass-data
sudo chmod 777 /srv/nfs/kubetesting/storageclass-data

sudo chown -R nobody:nogroup /srv/nfs/kubetesting/storageclass-data2
sudo chmod 777 /srv/nfs/kubetesting/storageclass-data2

sudo chown -R nobody:nogroup /srv/nfs/kubetesting/storageclass-data3
sudo chmod 777 /srv/nfs/kubetesting/storageclass-data3


echo "[TASK 4 Deleting and re creating exports file for updation"
sudo rm -r /etc/exports
sudo touch /etc/exports

echo "[TASK 5] Make the kubedata directory available on the network"
cat >>/etc/exports<<EOF
/srv/nfs/kubedata    *(rw,sync,no_subtree_check,no_root_squash)
/srv/nfs/kubedata/volume1  *(rw,sync,no_subtree_check,no_root_squash)
/srv/nfs/kubedata/volume2  *(rw,sync,no_subtree_check,no_root_squash)
/srv/nfs/kubetesting/storageclass-data   *(rw,sync,no_subtree_check,no_root_squash)
/srv/nfs/kubetesting/storageclass-data2   *(rw,sync,no_subtree_check,no_root_squash)
/srv/nfs/kubetesting/storageclass-data3   *(rw,sync,no_subtree_check,no_root_squash)
EOF

echo "[TASK 6] Export the updates"
sudo exportfs -rav

echo "[TASK 7] Enable NFS Server"
sudo systemctl enable nfs-server

echo "[TASK 8] Start NFS Server"
sudo systemctl start nfs-server
