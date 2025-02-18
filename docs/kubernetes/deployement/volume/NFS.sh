 sudo apt-get install nfs-kernel-server
 sudo mkdir -p /data/config
 sudo chmod 777 /data/config
 sudo chmod 777 /data/config
 sudo nano /etc/exports

/data/config *(rw,sync,no_subtree_check)

sudo exportfs -a
 showmount -e
