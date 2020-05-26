# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
192.168.50.100 nfs-server.example.com nfs-server
192.168.50.10 k8s-master
192.168.50.11 k8s-node-1
192.168.50.12 k8s-node-2
192.168.50.13 k8s-node-3
EOF

echo "[TASK 2] Download and install NFS server"
sudo apt install nfs-kernel-server

echo "[TASK 3] Create a kubedata directory"
mkdir -p /srv/nfs/kubedata
mkdir -p /srv/nfs/kubedata/db
mkdir -p /srv/nfs/kubedata/storage
mkdir -p /srv/nfs/kubedata/logs

mkdir -p /srv/nfs/kubetesting
mkdir -p /srv/nfs/kubetesting/bitnami-wordpress
mkdir -p /srv/nfs/kubetesting/storage
mkdir -p /srv/nfs/kubetesting/storageclass-data

echo "[TASK 4] Update the shared folder access"
sudo chown -R nobody:nogroup /srv/nfs/kubedata
sudo chmod 777 /srv/nfs/kubedata

sudo chown -R nobody:nogroup /srv/nfs/kubetesting
sudo chmod 777 /srv/nfs/kubetesting

sudo chown -R nobody:nogroup /srv/nfs/kubetesting/bitnami-wordpress
sudo chmod 777 /srv/nfs/kubetesting/bitnami-wordpress

sudo chown -R nobody:nogroup /srv/nfs/kubetesting/storage
sudo chmod 777 /srv/nfs/kubetesting/storage

sudo chown -R nobody:nogroup /srv/nfs/kubetesting/storageclass-data
sudo chmod 777 /srv/nfs/kubetesting/storageclass-data
echo "[TASK 5 Deleting and re creating exports file for updation"
sudo rm -r /etc/exports
sudo touch /etc/exports

echo "[TASK 5] Make the kubedata directory available on the network"
cat >>/etc/exports<<EOF
/srv/nfs/kubedata    *(rw,sync,no_subtree_check,no_root_squash)
/srv/nfs/kubetesting    *(rw,sync,no_subtree_check,no_root_squash)
/srv/nfs/kubetesting/bitnami-wordpress    *(rw,sync,no_subtree_check,no_root_squash)
/srv/nfs/kubetesting/storage   *(rw,sync,no_subtree_check,no_root_squash)
/srv/nfs/kubetesting/storageclass-data   *(rw,sync,no_subtree_check,no_root_squash)
EOF

echo "[TASK 6] Export the updates"
sudo exportfs -rav

echo "[TASK 7] Enable NFS Server"
sudo systemctl enable nfs-server

echo "[TASK 8] Start NFS Server"
sudo systemctl start nfs-server
