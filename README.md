# Logstash Codec Thrift

[![Gem Version](https://badge.fury.io/rb/logstash-codec-thrift.svg)](http://badge.fury.io/rb/logstash-codec-thrift) [![Build Status](https://travis-ci.org/oliviernt/logstash-codec-thrift.svg?branch=master)](https://travis-ci.org/oliviernt/logstash-codec-thrift)

## Install

    $ ./bin/plugin install logstash-codec-thrift

## Usage

```ruby
input {
  zeromq {
    codec => thrift {
      classname => "example_thrift_class"
      file => "/path/to/your/thrift/gen/ruby/example_thrift_class_types.rb"
      protocol_factory => "JsonProtocolFactory" # optional, defalut: BinaryProtocolFactory
    }
  }
}
```

## Install dependencies

Install jruby:

    $ brew install jruby

Install jruby bundler:

    $ jruby -S gem install bundler

Install plugin dependencies:

    $ jruby -S bundler install

## Build & Install

Build Gem:

    $ gem build logstash-codec-thrift.gemspec

Install Gem:

    $ ./bin/plugin install /your/local/plugin/logstash-codec-thrift.gem
