dnf -y update
dnf -y install mariadb
dnf install -y mariadb-server
dnf -y install httpd
dnf install https://rpm.nodesource.com/pub_21.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
update-crypto-policies --set DEFAULT:SHA1
#update-crypto-policies --set DEFAULT
dnf -y install nodejs --setopt=nodesource-nodejs.module_hotfixes=1
dnf -y update
systemctl enable mariadb.service
systemctl enable httpd.service
firewall-cmd --permanent --add-port=3000/tcp
firewall-cmd --permanent --add-port=80/tcp
# --skip-broken --nobest
sed 's/^SELINUX=enforcing$/SELINUX=disabled/g' /etc/selinux/config
cp files/krafttex_workers_3000.service /usr/lib/systemd/system/
cp files/krafttexMOD.motd /etc/motd.d/
dnf -y install cockpit
systemctl enable cockpit.socket
cp files/disallowed-users /etc/cockpit
cp files/branding.css /usr/share/cockpit/branding/rhel
cp files/logo.png /usr/share/cockpit/branding/rhel
dnf -y install chrony
systemctl enable chronyd
cp files/chrony.conf /etc/
reboot
