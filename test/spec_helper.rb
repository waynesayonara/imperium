if(ENV['CODECLIMATE_REPO_TOKEN'])
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require_relative '../lib/imperium/imperium_main'
require 'rspec'

$window = Imperium::ImperiumMain.new
RSpec.configure do |config|
end