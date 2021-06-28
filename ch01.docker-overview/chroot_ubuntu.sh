mkdir -p {bin,lib,lib64}
cp /bin/{bash,ls} bin
ldd /bin/bash | egrep -o '/lib.*\.[0-9]'
list="$(ldd /bin/bash | egrep -o '/lib.*\.[0-9]')"
for i in $list; do cp -v "$i" "/home/educafe/lab/lib/"; done

ldd /bin/bash | egrep -o '/lib64/.*\.[0-9]'
list="$(ldd /bin/bash | egrep -o '/lib64/.*\.[0-9]')"
for i in $list; do cp -v "$i" "/home/educafe/lab/lib64/"; done
#cp $list lib64

ldd /bin/ls | egrep -o '/lib.*\.[0-9]'
list="$(ldd /bin/ls | egrep -o '/lib.*\.[0-9]')"
for i in $list; do cp -v "$i" "/home/educafe/lab/lib/"; done

ldd /bin/ls | egrep -o '/lib64/.*\.[0-9]'
list="$(ldd /bin/ls | egrep -o '/lib64/.*\.[0-9]')"
for i in $list; do cp -v "$i" "/home/educafe/lab/lib64/"; done
#cp $list lib64

sudo chroot /home/educafe/lab

