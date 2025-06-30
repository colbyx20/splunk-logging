docker run --name splunk -p 8000:8000 -p 8088:8088 -e SPLUNK_START_ARGS="--accept-license" -e SPLUNK_PASSWORD="mypassword" splunk/splunk:latest


<system></system> block is for global settings

1. root_dir -> specify fluentd's temp files
2. log_level -> [info, warn, debug, error, fatal] - > fluentd's own logs
3. workers -> tells fluentd to run multiple worker process

<system>
  root_dir /fluentd/buffer
  log_level info
</system>


<source> blocks
1. Where fluentd reads logs from
2. Each source plugin knowsh ow to inject data
3. Every <source> assigns tags to the logs
4. Think of - It's like your log Inbox

tail logs from path location - each log line gets nginx.access tag
<source>
	@type tail
	path /var/log/nginx/access.log
	pos_file /fluentd/pos/access.pos
	tag nginx.access
	format nginx
</source>

Listen on TCP ports
<source>
	@type forward
	port 24224
</source>

Match block
1. Tells FluentD Where to Send Logs
2. Routes logs by tag matching (eg. nginx.access)
3. Defines how logs are output (stdout, Elasticsearch, files, cloud services)
4. It's your Log "Outbox"

stdout
<match nginx.access>
	@type stdout
</match>

Write to a file
<match nginx.access>
	@type file
	path /fluentd/logs/nginx_access
</match>

Send to ElasticSearch
<match nginx.access>
	@type leasticsearch
	host elasticsearch
	port 9200
	index_name nginx-access
</match>
```


How does FluentD Connect Source and Match??
```text
<source> -> creates logs and assigns a tag
<match> -> catches logs based on that tag and sends logs somewhere
```

Tag Patterns
```text
Exact Tag -> <match nginx.access>
Wildcard  -> <match nginx.*>
All Logs  -> <match **>

How it connects
<source>
	@type tail
	path /var/log/nginx/access.log
	pos_file /fluentd/pos/access.pos
	tag nginx.access
	format nginx
</source>

<match nginx.access>
	@type stdout
</match>

1. Tail log file
2. Emits events with tag nginx.access
3. Match block prints those logs to stdout
```

Filters
```txt
<source> -> <filter> -> <match>
1. Transforms Logs
2. remove fields
3. add metadata

<filter nginx.access>
	@type record_transformer
	<record>
		hostname "#{Socket.gethostname}"
	</record>
</filter>
```

TL;DR
```text
<ource> -> Where logs come from
<match> -> Where logs go
tags    -> connect the two

SOURCE -> TAG -> MATCH
```
