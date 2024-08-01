#!/bin/bash

sudo apt update
sudo apt install -y apache2

myip=`curl ifconfig.io`

cat <<EOF > /var/www/gci/index.html
<html>
<h2>Build by Power of Terraform <font-color="red">v0.12</font></h2><br>
Owner ${f_name} ${l_name} <br>
%{ for x in names ~}
Hello to ${x} from ${f_name}<br>
%{ endfor ~}
</html>
EOF

sudo service apache2 reload