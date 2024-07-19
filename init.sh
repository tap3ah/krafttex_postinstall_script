dnf -y update
dnf -y install mariadb
dnf install -y mariadb-server
dnf -y install httpd
dnf -y install nano
curl -sL https://rpm.nodesource.com/setup_22.x -o nodesource_setup.sh
chmod +x ./nodesource_setup.sh
./nodesource_setup.sh
update-crypto-policies --set DEFAULT:SHA1
#update-crypto-policies --set DEFAULT
dnf -y install nodejs --setopt=nodesource-nodejs.module_hotfixes=1
dnf -y install make gcc-c++
dnf -y update
echo '[mysqld_safe]' >> /etc/my.cnf
echo 'timezone=UTC' >> /etc/my.cnf
systemctl enable mariadb.service
systemctl enable httpd.service
firewall-cmd --permanent --add-port=3000/tcp
firewall-cmd --permanent --add-port=80/tcp
# --skip-broken --nobest
sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/g' /etc/selinux/config
cp files/krafttex_workers_3000.service /usr/lib/systemd/system/
cp files/krafttex_api.service /usr/lib/systemd/system/
#systemctl enable krafttex_workers_3000.service
#systemctl enable krafttex_api.service
cp files/krafttexMOD.motd /etc/motd.d/
dnf -y install cockpit
systemctl enable cockpit.socket
cp files/disallowed-users /etc/cockpit
cp files/branding.css /usr/share/cockpit/branding/rhel
cp files/logo.png /usr/share/cockpit/branding/rhel
dnf -y install chrony
systemctl enable chronyd
cp files/chrony.conf /etc/
mysql -h localhost -u root -r < files/root.sql
mysql -h localhost -u root -r raus < files/db.sql
reboot
