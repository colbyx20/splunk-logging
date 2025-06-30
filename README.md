docker run --name splunk -p 8000:8000 -p 8088:8088 -e SPLUNK_START_ARGS="--accept-license" -e SPLUNK_PASSWORD="mypassword" splunk/splunk:latest
