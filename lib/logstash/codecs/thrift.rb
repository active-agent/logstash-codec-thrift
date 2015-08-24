# encoding: utf-8
require "json"
require "logger"
require "logstash/codecs/base"
require "thrift"
require "logstash/codecs/thrift-event"

# Read serialized Thrift records as Logstash events
#
# This plugin is used to serialize Logstash events as 
# Thrift objects, as well as deserializing Thrift objects into 
# Logstash events.
#
# ==== Encoding
# 
# This codec is for serializing individual Logstash events as Thrift.
#
#
# ==== Decoding
#
# This codec is for deserializing individual Thrift serialized objects as Logstash events.
#
#
# ==== Usage
# Example usage with 0mq input.
#
# [source,ruby]
# ----------------------------------
# input {
#   zeromq {
#     codec => thrift {
#       classname => "example_class"
#       file => "~/example_class.rb"
#       protocol_factory => "JsonProtocolFactory"
#     }
#   }
# }
# filter {
#   ...
# }
# output {
#   ...
# }
# ----------------------------------
class LogStash::Codecs::Thrift < LogStash::Codecs::Base

    config_name "thrift"

    # class name to serialize/deserialize against
    config :classname, :validate => :string, :required => true
    
    # file defining @classname
    config :file, :validate => :string, :required => true

    # protocol factory to use for serialization/deserialization
    #
    # see http://www.rubydoc.info/gems/thrift/latest/Thrift/Serializer for more info
    config :protocol_factory, :validate => :string, :required => false, :default => "BinaryProtocolFactory"
    
    public
    def register
        @logger.info("Initializing logstash thrift codec for class: " + @classname)
        require @file
        @clazz = Object.const_get(@classname.capitalize)
        @protocolFactory = Thrift.const_get(@protocol_factory)
        @logger.info("Done initializing logstash thrift codec!")
    end

    public
    def decode(data)
        deserializer = Thrift::Deserializer.new(@protocolFactory.new)
        yield LogStash::Event.new(as_hash(deserializer.deserialize(@clazz.new, data)))
    end

    public
    def encode(event)
        serializer = Thrift::Serializer.new(@protocolFactory.new)
        thriftEvent = ThriftEvent.new
        thriftEvent.timestamp = event["@timestamp"].to_s
        thriftEvent.version = event["@version"]
        thriftEvent.host = event["host"]
        thriftEvent.message = event["message"]
        @on_event.call(event, serializer.serialize(thriftEvent))
    end

    private
    def as_hash(obj)
        if obj.is_a?(TrueClass) | obj.is_a?(FalseClass) | obj.is_a?(String) | obj.is_a?(Numeric)
            hash = obj
        elsif obj.is_a?(Array)
            hash = []
            obj.each { |var|
                hash.push(as_hash(var))
            }
        else
            hash = {}
            obj.instance_variables.each { |var|
                key = var.to_s.delete("@")
                value = obj.instance_variable_get(var)
                hash[key] = as_hash(value)
            }
        end
        hash
    end

end
