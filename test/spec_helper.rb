require 'codeclimate-test-reporter'
require_relative '../lib/imperium/imperium_main'
require 'rspec'

ENV['CODECLIMATE_REPO_TOKEN'] = '9d20f21fc1b16cadd10b7962abc77594fae7c6db52b86a1'
CodeClimate::TestReporter.start

$window = Imperium::ImperiumMain.new
RSpec.configure do |config|
end