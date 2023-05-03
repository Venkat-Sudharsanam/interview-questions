# Interview Questions
>Question 1 
- Provision a VM in any public cloud (AWS/AZURE/Google Cloud ) using any tools like Ansible, Terraform or Python.

- [x] Using SSH automation Ensure apache/Any web server is running. You should be able to see a test page going here in your browser: http://localhost:8080/app
- [x] Reconfigure apache/Any web server to run using HTTPS rather than HTTP. Any HTTP links should redirect to HTTPS. 
- [x] You should be able to see the exact same test page as above by going here in your browser: https://localhost:8443/app
- [x] You will get an exception about an insecure connection due to the self-signed cert. Feel free to ignore this.
- [x] Create a tar.gz of your automation and interviewer should able to execte above mentioned steps via single script/API.

>Question 2

1. write linux a program to print space of each directory and space of filesystem and if space above is 80 % then 
  - [x] Add a new disk
  - [x] Mount the directory which is having disk space > 80%

2. Write linux a program to  connect remote linux VM and perform following steps 
  - [x] Check version of linux kernel 
  - [x] List the package(rpm/dpkg) and its versions installed on remote machine in sorted order
  - [x] Get list process running on remote machines
3. [x] Provide your Github repo and output  of the script.

>Question 3

1. Develop rest api having below endpoint 
  - [x] /square - O/p square of provided number
  - [x] /cube - O/P cube of provided number
  - [x] /squareroot - O/P square root of provided number
	
    - [x] Input the number as a payload 
    - [x] You can use any programming language of your choice.
2. Write a Jenkins file to deployment web application
	- [x] develop docker file for web application
	- [x] Deploy application to Kubernetes cluster
4. [x] Provide your GitHub repo.
5. [] Try to build token based authentication if possible. You can use PING/auth0 kind of identity provider.