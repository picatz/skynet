echo "apache" > /etc/hostname
sudo yum install vim httpd -y
sudo cp /etc/httpd/conf/httpd.conf ~/httpd.conf.bak
sudo bash -c "curl https://raw.githubusercontent.com/picatz/skynet/master/examples/centos7_apache/httpd.conf > /etc/httpd/conf/httpd.conf"
sudo bash -c "echo 'Made with ♥ by picat' > /var/www/html/index.html"
sudo systemctl enable httpd
sudo systemctl start httpd
curl localhost
