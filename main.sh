#Check if there is docker installed
if [[ $(which docker) != /usr/bin/docker ]] ; then
    sudo yum update -y
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install docker-ce -y
fi

#Check if docker is running
docker run hello-world
if [[ $? -ne 0 ]]; then
    sudo service docker start
    sleep 1;
    docker run hello-world
    if [[ $? -ne 0 ]] ; then 
        echo "Failed to execute docker"
        exit -1
    fi
fi


