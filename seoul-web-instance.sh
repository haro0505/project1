#!/bin/bash
yum install -y httpd
systemctl start httpd
systemctl enable httpd
instance_id=$(ec2-metadata -i | cut -d ' ' -f 2)
private_id=$(ec2-metadata -o | cut -d ' ' -f 2)
az_name=$(ec2-metadata -z | cut -d ' ' -f 2)
cat <<EOF > /var/www/html/index.html
<h1>서울 웹 서버에 오신것을 환영합니다.</h1>
<h3>인스턴스 ID : ${instance_id}</h3>
<h3>사설 IP : ${private_id}</h3>
<h3>가용영역 : ${az_name}</h3>
<img src "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_aws.jpg" width=500>
EDF
