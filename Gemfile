source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'virtus'

gem 'crypto_math', github: 'BrandyMint/crypto_math'
gem 'auto_logger', github: 'BrandyMint/auto_logger'
# Можно перейти в master если туда влили этот PR https://github.com/Netflix/fast_jsonapi/pull/230
# Данные изменения отлавливаются в spec/serializers/order_serializer_spec.rb
gem 'fast_jsonapi', github: 'HoJSim/fast_jsonapi', branch: 'dev'

# Use for delegation
gem 'activesupport'

gem 'money', '~> 6.11'
gem 'money-rails', '~> 1.11'

gem "redis", "~> 4.0", :require => ["redis", "redis/connection/hiredis"]
gem 'redis-namespace'
gem 'oj'
gem 'rcsv' # Rcsv is a fast CSV parsing library for MRI Ruby
gem 'rubyzip', '>= 1.0.0' # will load new rubyzip version
gem 'grape'
gem 'grape-entity'

gem 'sidekiq'

# In Gem hell migrating to RubyZip v1.0.0? Include zip-zip in your Gemfile and everything's coming up roses!
# для axlsx
gem 'zip-zip'


group :test do
    gem 'vcr'
    gem 'webmock'
end

# Specify your gem's dependencies in best_change.gemspec
gemspec
