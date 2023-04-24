### How applicaiton works

```
The UI has given option for the user to enter a number. 

User is given 3 option, square, cube and square root.

Once user clicks on any of the options, rest api is called and get output from backend.
```
```
The backend has 3 rest apis - /square, /squareroot, /cube
```
```
Fronend is written in node and html.
backend is Python applicaiton
```
### Jenkins file

To run the jenkinsfile, we need to update few variables in it.
So it can run and build the application and deploy it to kubernetes namespace.
```
environment {
    AWS_DEFAULT_REGION = 'your-aws-region'
    ECR_REGISTRY = 'your-ecr-registry'
    ECR_REPOSITORY_FRONTEND = 'your-ecr-repository-frontend'
    ECR_REPOSITORY_BACKEND = 'your-ecr-repository-backend'
    EKS_CLUSTER_NAME = 'your-eks-cluster-name'
    K8S_NAMESPACE = 'your-k8s-namespace'
}
```
```
Also your-aws-credentials-id, to connect to the aws account
```