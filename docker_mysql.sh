randomPassword="$(date +%s | sha256sum | base64 | head -c 32)"

#Need to check if there is running testting-mysql containers
#docker 
docker pull mysql/mysql-server:5.7 

if [[ $? -ne 0 ]] ;then
    echo "Failed to get docker images mysql/mysql-server:5.7"
    exit -1
fi

containerName="testing-mysql"
if [[ $(docker container ls|grep $containerName) != "" ]]; then
    docker stop $containerName
    docker container rm $containerName
fi

docker run --name $containerName -e MYSQL_ROOT_PASSWORD=$randomPassword -d mysql/mysql-server:5.7 \
    && sleep 10 \
    && docker exec -it $containerName mysql -uroot --password=$randomPassword


#link to $containerName from another docker container
#docker run --name app-container-name --link tesint-mysql:mysql -d app-that-uses-mysql






