#!/bin/bash

sudo apt update
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

myip=`curl ifconfig.io`

cat <<EOF > /var/www/html/index.html
<html>
<h2>WebServer with IP: $myip</h2><br><h2>Build by <font color="red">Terraform</font> using External Script!</h2><br>
Owner ${f_name} ${l_name} <br>

%{ for x in names ~}
Hello to ${x} from ${f_name}<br>
%{ endfor }
</html>
EOF

sudo systemctl restart nginx