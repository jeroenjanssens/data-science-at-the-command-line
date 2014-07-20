apt-get install -y virtualbox-guest-additions-iso
mount -o loop /usr/share/virtualbox/VBoxGuestAdditions.iso /mnt
/mnt/VBoxLinuxAdditions.run
ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
