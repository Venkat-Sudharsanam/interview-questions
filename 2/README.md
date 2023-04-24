## SSH and running script

For this problem, we have dockerfile to build a container so that we can ssh into that to run the script

build the docker image on the local.
```
docker build -t testingubuntu .
```

Once the docker image is build, run the image.
```
docker run -d -p 2222:22 --name random-container testingubuntu
```
now, we can ssh into the container by
```
ssh newuser@localhost -p 2222 'bash -s' < ./script.sh
```
When prompted for password, use "newpassword". we can change the build password to action or jenkins to keep the ssh login secure