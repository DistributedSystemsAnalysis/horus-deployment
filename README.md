# Instructions

## Setting up Horus Pipeline

### Installing Horus Events package
- Clone `horus-events` repository
- Run `mvn install`

### Building Horus Processor
- Clone `horus-event-consumer` (processor)
- Run `mvn package -DskipTests` (install Neo4j 3.x in your local enviroment if running without -DskipTests)
- `docker build --tag fntneves/horus-processor .`

### (Optional) Add Horus Neo4j algorithms as Neo4j plugin
This is already included in the deployment `.zip` file.
If in any case, you need to update the plugin, do the following.

- Clone `horus-neo4j-algo`
- Run `mvn package`
- Copy .jar from `target/` to `neo4j/plugins/`
- Restart Neo4j Docker if it is running

### (Optional) Update Horus configuration
Horus comes with default configuration in `processor/conf`.
It includes tunnable performance parameters and log4j configuration.
For debugging the Horus processor, open the `conf/log4j2.properties` file and set the `logger.horus.level` value to `DEBUG`.

### Preparing Docker for Horus
- `docker network create horus_network`

### Update Docker Configuration
- Update `docker-compose.yml` by replacing all instances of `<EXTERNAL_IP_ADDRESS>` with the actual external IP address of the host where each service will be deployed. Otherwise, remove JMX-related flags.
- Replace all `<EXTERNAL_HOSTNAME>` occurences with the actual hostname where the deploy will run on

### Starting Horus
Hopefully, no additional configuration is needed in `docker-compose.yml`.
- `docker network create horus_network`
- `docker-compose up`

### Add indexes to the Neo4j database
- Execute the `add_neo4j_indexes.sh` file
- Alternatively, run the queries manually in the browser, at `http://localhost:7474`

### Testing the system
- Clone  `horus-benchmarks`
- Update the `KafkaWriter` constructor argument in `kafka-event-seeder.py` to match your Kafka host.
- Run `python kafka-event-seeder.py 2` to seed the Neo4j database with 2 (SND -> RCV) pairs, i.e., 4 events in total.
- You should see the expected events and relationsips in Neo4j Browser

> Note: If any import errors occur, run `pip <package>` for each missing package.

### Resetting the system
To clear all data and reboot the system in empty state, run the `reset_cluster.sh` script.
It will delete all temporary files, reboot docker containers and re-create indexes.
This is useful while repeating tests.

## For Applications

### Building log4j appender (for collecting logs from Java applications)
- Clone `horus-lo4j-appender`
- Run `mvn package`
- Copy .jar in `target/` folder to the application's jar folder and update the Log4j configuration to consider the new appender (see `log4j.properties` example in `example-java-application` repository)

