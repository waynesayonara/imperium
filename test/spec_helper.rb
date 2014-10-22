require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require_relative '../lib/imperium/imperium_main'
require 'rspec'


$window = Imperium::ImperiumMain.new
RSpec.configure do |config|
end