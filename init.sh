dnf -y update
dnf -y install mariadb
dnf install -y mariadb-server
dnf -y install httpd
dnf -y install https://rpm.nodesource.com/pub_20.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
update-crypto-policies --set DEFAULT:SHA1
dnf -y install nodejs
update-crypto-policies --set DEFAULT
dnf -y update
systemctl enable mariadb.service
systemctl enable httpd.service
firewall-cmd --add-port=3000/tcp
firewall-cmd --add-port=80/tcp
# --skip-broken --nobest
