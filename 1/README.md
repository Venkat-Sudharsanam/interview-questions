# TF code for instance creation and configuring httpd

tf-code folder --> this code to create new instance in aws.
1. In your local or the environment where you need to run, have the below file ready:

```
cat ~/.aws/config 
[default] 
aws_access_key_id=
aws_secret_access_key=
region=
output=text
```
2. go to the folder to the the below commands,

```
terraform init
terraform plan
terraform apply -auto-approve
```

tf-code-venkat-aws folder ---> This code is already created environment.

> You can access it by below http://3.74.6.157:8080/, which will take you to https://3.74.6.157:8443/

>You can access it by below http://3.74.6.157:8080/app, which will take you to https://3.74.6.157:8443/app

> You can directly access https://3.74.6.157:8443/ or https://3.74.6.157:8443/app