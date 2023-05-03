# TF code for instance creation and configuring httpd

tf-code folder --> this code to create new instance in aws.
1. In your local or the environment where you need to run, have the below file ready:

```
cat /Users/venkatsudharsanam/.aws/config 
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

> You can access it by below http://3.65.49.65/, which will take you to https://3.65.49.65/

>You can access it by below http://3.65.49.65/app, which will take you to https://3.65.49.65/app

> You can directly access https://3.65.49.65/ or https://3.65.49.65/app