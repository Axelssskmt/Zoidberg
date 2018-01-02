### KS for upgrade bond test on dell-per510-01

### Language ###
lang en_US.UTF-8

### Timezone ###
timezone Asia/Shanghai --utc --ntpservers=clock02.util.phx2.redhat.com

### Keyboard ###
keyboard --vckeymap=us --xlayouts='us'

### Kdump ###

### Security ###

### User ###
rootpw --plaintext redhat
auth --enableshadow --passalgo=sha512

### Misc ###
services --enabled=sshd

### Installation mode ###
install
#liveimg url will be substitued by autoframework
liveimg --url=http://10.66.10.22:8090/rhvh_ngn/squashimg/redhat-virtualization-host-4.1-20170202.0/redhat-virtualization-host-4.1-20170202.0.x86_64.liveimg.squashfs
text
reboot

### Network ###
#network --device=bond0 --bootproto=static --ip=10.73.75.35 --netmask=255.255.252.0 --gateway=10.73.75.254 --bondslaves=em1,em2 --bondopts=mode=active-backup,primary=em2,miimon=100
#network --device=em2 --bootproto=dhcp
network --device=bond0 --bootproto=dhcp --bondslaves=em1,em2 --bondopts=mode=active-backup,primary=em2,miimon=100

### Partitioning ###
ignoredisk --drives=/dev/disk/by-id/scsi-36782bcb03cdfa2001ebc7e930f1ca244,/dev/disk/by-id/scsi-36005076300810b3e0000000000000270
zerombr
clearpart --all
bootloader --location=mbr
autopart --type=thinp

### Pre deal ###

### Post deal ###
%post --erroronfail
imgbase layout --init
%end