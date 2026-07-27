FROM scratch
ADD ubuntu-rootfs.tar.gz .
CMD ["/bin/bash"]

# mkdir ubuntu-rootfs
# sudo mkdir /mnt/ubuntu-iso
# sudo mount -o loop ubuntu-24.04-live-server-amd64.iso /mnt/ubuntu-iso

# sudo unsquashfs -f -d ~/ubuntu-rootfs /mnt/ubuntu-iso/casper/ubuntu-server-minimal.squashfs
# sudo tar -C ~/ubuntu-rootfs -czf ubuntu-rootfs.tar.gz .

# docker import ubuntu-rootfs.tar.gz ubuntu:24.04
