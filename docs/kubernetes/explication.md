# awel haja 

temshi tsob el docker w trestartih w tenablih w tchouf el status te3o est ce que active walla le 

sudo apt update

sudo apt install docker.io -y

sudo systemctl enable docker


sudo systemctl status docker

sudo systemctl status docker

## theni hkeya lezem tinstalli el k8s 

kifeh si ala ? 

lezemk tziid el signing key for each node 

<span  style="color:red"> curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg  </span>


w tzid el depot tee3 el k8s fil ubuntu 

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

baadha barra aa3mel update 

sudo apt update 

## thleth haja barra installi el k8s tools 

sudo apt install kubeadm kubelet kubectl

sudo apt-mark hold kubeadm kubelet kubectl    

el commande elli kbalha chniya el obj teeha ? ennek ki yabda 3andek par exemple kubectl el version te3o 1.31 w taamel update el version te3o tetbaddelsh 

kubeadm version

## taw lezem deployi k8s so hadher el env 


awel haja ennek tsakker el swap besh el k8s yaaref ydetecti kaddeh bedhabt mzl ram wel swap y8allet 

sudo swapoff -a


lezemk ki yet7al el pc el swapp yarjaa3sh yet7all so lezme el swapp ykoun msaker permat 

sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab


el containerd besh yekhdem noraml lezemo kaddeh mn modules yabda mawjoud w mriigl comme il faut soo lezm 2 modules elli houma el overlay w br-netfilter walla faza hakka louleli ypermeti de gerer le stoccakge des container besh kol chy ykoun yekhdme smooothly w mriigl w theni ygeri les t rafic de reseau qui passe vers le docker ou le conainterd 

so ... lezemk tmodifi fil fichier 

sudo nano /etc/modules-load.d/containerd.conf

w t7ott fi wsto esm les modules adhoukm besh ykoun kol chy mriigl 

overlay
br_netfilter  

taw si ala pour appliquer la modif je dois faire la commande   

sudo modprobe overlay

sudo modprobe br_netfilter

taw lezem netelhew bi networking so lezem 

sudo nano /etc/sysctl.d/kubernetes.conf

w nhotto fiiih 

net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1


besh tappliki el modif 

sudo sysctl --system
