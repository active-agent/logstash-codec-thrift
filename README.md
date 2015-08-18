# Logstash Codec Thrift


## Install dependencies

Install jruby:

    $ brew install jruby

Install jruby bundler:

    $ jruby -S gem install bundler


Bundle the package:

    $ jruby -S bundler install


## Try it out

bin/logstash -e 'input { file { path => "/var/lib/dsp/importer/auctions*" codec => thrift { classname => "auction_log_entry" }} } output {stdout { codec => rubydebug }}'
