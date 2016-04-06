Gem::Specification.new do |s|

  s.name            = 'logstash-codec-thrift'
  s.version         = '0.2.0'
  s.licenses        = ['Apache License (2.0)']
  s.summary         = "This example input streams a string at a definable interval."
  s.description     = "This gem is a logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/plugin install gemname. This gem is not a stand-alone program"
  s.authors         = ["Active Agent AG"]
  s.email           = 'dev@active-agent.com'
  s.homepage        = "http://active-agent.com"
  s.require_paths   = ["lib"]

  # Files
  s.files = Dir['lib/**/*','*.gemspec','*.md','Gemfile']

  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "codec" }

  # Gem dependencies
  s.add_runtime_dependency 'logstash-core-plugin-api', '~> 1.0'
  s.add_runtime_dependency 'thrift'

  s.add_development_dependency 'logstash-devutils', '>= 0.0.15'

end
