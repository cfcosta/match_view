require "bundler/setup"

require 'rspec/given'

require "match_view"

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!

  config.filter_gems_from_backtrace 'given_core'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
