dnf -y update
dnf -y install mariadb
dnf -y install httpd
dnf -y install https://rpm.nodesource.com/pub_20.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
update-crypto-policies --set DEFAULT:SHA1
dnf -y install nodejs
update-crypto-policies --set DEFAULT
dnf -y update
# --skip-broken --nobest
