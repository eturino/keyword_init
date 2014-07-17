require 'bundler/setup'
Bundler.setup

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'pry'
require 'keyword_init'

RSpec.configure do |config|
  # some (optional) config here
end
