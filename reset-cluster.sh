docker-compose rm -svf

sudo rm -rf zk/{data,logs}
sudo rm -rf neo4j/logs/*
sudo rm -rf neo4j/data/*
sudo rm -rf neo4j/data-tmpfs/*
sudo rm -rf kafka/{data,logs}
sudo rm -f processor/logs/*

docker-compose up -d

sleep 10

until sh add_neo4j_indexes.sh
do
  echo "Trying again"
  sleep 3
done
