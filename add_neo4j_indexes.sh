QUERY1="CREATE CONSTRAINT ON (event:EVENT) ASSERT event.eventId IS UNIQUE;"
QUERY2="CREATE INDEX ON :EVENT(lamportLogicalTime);"

curl -X POST -H 'Content-type: application/json' \
	http://localhost:7474/db/data/transaction/commit -d "{\"statements\": [{\"statement\": \"$QUERY1\"}, {\"statement\": \"$QUERY2\"}]}"
