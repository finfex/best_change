require "bundler/setup"
Bundler.require(:test)

# Подгружать ДО BestChange
require_relative 'support/stub'

require 'virtus'
require 'grape'
require 'grape-entity'
require 'auto_logger'
require 'fast_jsonapi'
require 'sidekiq'

require 'money'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/core_ext/module/delegation'
require 'active_support/all'
require 'active_support/core_ext/module'

# TODO вынести в crypto_math
require_relative 'support/mathematic'
require_relative 'support/rate_from_multiplicator'
require_relative 'support/rate'
require_relative 'support/currency_pair'
require_relative 'support/money'

require "best_change"

BestChange.configure do |config|
  config.redis = "redis://#{ENV['REDIS_HOST'] || 'localhost' }:6379/1"
  config.exchanger_id = 522
  config.valuta_access_log = './log/valuta_access.log'
end

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  # c.allow_http_connections_when_no_cassette = true
  c.ignore_localhost = true
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
