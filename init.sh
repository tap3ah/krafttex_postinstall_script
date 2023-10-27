dnf -y update
dnf -y install mariadb
dnf install -y mariadb-server
dnf -y install httpd
dnf install https://rpm.nodesource.com/pub_21.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
update-crypto-policies --set DEFAULT:SHA1
dnf install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1
update-crypto-policies --set DEFAULT
dnf -y update
systemctl enable mariadb.service
systemctl enable httpd.service
firewall-cmd --permanent --add-port=3000/tcp
firewall-cmd --permanent --add-port=80/tcp
# --skip-broken --nobest
