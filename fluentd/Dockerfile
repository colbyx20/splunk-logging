FROM fluent/fluentd:v1.16-1

USER root

COPY fluent.conf /fluentd/etc/

RUN mkdir -p /fluentd/log
RUN gem install fluent-plugin-splunk-hec --no-document

USER fluent
