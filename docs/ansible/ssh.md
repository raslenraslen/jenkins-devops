## fil master node aamel 

````bash
ssh-keygen -t rsa -b 4096
 ````

``` bash
cat ~/.ssh/id_rsa.pub
````

## fil worker node aamel 

`````bash
nano ~/.ssh/authorized_keys

``````

coper coller taw el ssh key tee el public fil authorized key tee el worker 

soo w vrifi les 

les  
```` bash
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh

````

after that barra verifi el cnx SSH  fil master node 

`````bash

ssh root@192.168.100.35
 ``````

ko
