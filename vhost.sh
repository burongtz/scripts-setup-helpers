#!/bin/bash

#
# Create new file $1.conf
# $1 'dominio.local'
# $2 'domainRoot/frontend/'
# $3 'domainRoot/frontend/public'
#
new_conf() {
    tags="<VirtualHost *:80>"
    tags+="\n"

    tags+="\t"
    tags+="ServerName $1"
    tags+="\n\t"
    tags+="ServerAlias www.$1"
    tags+="\n\t"
    tags+="ServerAdmin webmaster@localhost"

    tags+="\n\t"
    tags+="DocumentRoot /var/www/html/$3"
    tags+="\n\t"
    tags+="ErrorLog /var/www/html/$2/error.log"
    tags+="\n\t"
    tags+="CustomLog /var/www/html/$2/access.log combined"

    tags+="\n\t"
    tags+="<Directory /var/www/>"
    tags+="\n\t\t"
    tags+="Options Indexes FollowSymLinks MultiViews"
    tags+="\n\t\t"
    tags+="AllowOverride All"
    tags+="\n\t\t"
    tags+="Order allow,deny"
    tags+="\n\t\t"
    tags+="allow from all"
    tags+="\n\t"
    tags+="</Directory>"

    tags+="\n"
    tags+="</VirtualHost>"
    tags+="\n"


    echo -e $tags >> /etc/apache2/sites-available/$1.conf
}

#
# $1 'dominio.local'
#
new_hosts() {
    echo -e "\n127.0.0.1\t$1\n" >> /etc/hosts
}

# Check if the function exists (bash specific)
if declare -f "$1" > /dev/null
then
  "$@"
else
  echo "'$1' is not a known function name" >&2
  exit 1
fi