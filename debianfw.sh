#!/bin/bash

## Updating the operating system
apt update && apt upgrade -y

## Installing useful things
apt install vim rcconf lynx -y

cp /home/joao/.bashrc .

## Changing terminal resolution
sed -i '23s/^#//g' /etc/default/grub
#sed -i '23s/640x480/1024x768/' /etc/default/grub
#sed -i "24i GRUB_GFXPAYLOAD_LINUX=1024x768" /etc/default/grub
sed -i '23s/640x480/800x600/' /etc/default/grub
sed -i "24i GRUB_GFXPAYLOAD_LINUX=800x600" /etc/default/grub
update-grub

# ## Editing file interfaces
# sed -i '12s/dhcp/static/' /etc/network/interfaces
# cat >> /etc/network/interfaces <<EOF
# address 192.168.1.10/24
# gateway 192.168.1.1
# EOF

## Editing file sysctl.conf
sed -i '28s/^#//g' /etc/sysctl.conf #enable forwarding for IPv4
sed -i "\$anet.ipv6.conf.all.disable_ipv6 = 1" /etc/sysctl.conf #disable IPv6

## Installing Bind
apt install bind9 bind9-doc dnsutils -y

## Adjusting Bind
#sed -i '23s/$/#/' /etc/bind/named.conf.options

## Adjusting resolv.conf
# cat > /etc/resolv.conf <<EOF
# domain abc.local
# search abc.local
# nameserver 127.0.0.1
# namesever 192.168.1.1
# EOF

apt install iptables squid apache2 apache2-doc -y

wget https://nethauslinux.s3.amazonaws.com/files.zip
unzip files.zip

mv firewall.service /lib/systemd/system/
mv firewall /etc/systemd/system/
chmod +x /etc/systemd/system/firewall
chmod 700 firewalloff
systemctl daemon-reload
systemctl enable firewall
mv wpad.dat /var/www/html/
mv dominio /etc/squid/
cp /etc/squid/squid.conf /etc/squid/squid.conf.ori
rm files.zip
rm notes

echo "done"