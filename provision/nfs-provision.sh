# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
192.168.50.100 nfs-server
EOF

echo "[TASK 2] Download and install NFS server"
sudo apt install nfs-kernel-server

echo "[TASK 3] Create a kubedata directory"
mkdir -p /srv/nfs/kubedata
mkdir -p /srv/nfs/kubedata/db
mkdir -p /srv/nfs/kubedata/storage
mkdir -p /srv/nfs/kubedata/logs

echo "[TASK 4] Update the shared folder access"
sudo chown -R nobody:nogroup /srv/nfs/kubedata
sudo chmod 777 /srv/nfs/kubedata


echo "[TASK 5] Make the kubedata directory available on the network"
cat >>/etc/exports<<EOF
/srv/nfs/kubedata    *(rw,sync,no_subtree_check,no_root_squash)
EOF

echo "[TASK 6] Export the updates"
sudo exportfs -rav

echo "[TASK 7] Enable NFS Server"
sudo systemctl enable nfs-server

echo "[TASK 8] Start NFS Server"
sudo systemctl start nfs-server