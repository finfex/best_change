
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "best_change/version"

Gem::Specification.new do |spec|
    spec.name          = "best_change"
    spec.version       = BestChange::VERSION
    spec.authors       = ["Danil Pismenny"]
    spec.email         = ["danil@brandymint.ru"]

    spec.summary       = %q{Adapter and utilities to work with data from bestchange.ru}
    spec.description   = %q{BestChange lib}
    spec.homepage      = ""
    spec.license       = "MIT"

    # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
    # to allow pushing to a single host or delete this section to allow pushing to any host.
    if spec.respond_to?(:metadata)
        spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
    else
        raise "RubyGems 2.0 or newer is required to protect against " \
            "public gem pushes."
    end

    # Specify which files should be added to the gem when it is released.
    # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
    #spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    #`git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    #end
    spec.bindir        = "exe"
    spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.require_paths = ["lib"]

    spec.add_dependency "virtus"
    spec.add_dependency "gera"
    spec.add_dependency "auto_logger"
    spec.add_dependency "fast_jsonapi"

    # Use for delegation
    spec.add_dependency 'activesupport'

    spec.add_dependency 'money', '~> 6.11'
    spec.add_dependency 'money-rails', '~> 1.11'

    spec.add_dependency "redis", "~> 4.0"
    spec.add_dependency 'redis-namespace'
    spec.add_dependency 'oj'
    spec.add_dependency 'rcsv' # Rcsv is a fast CSV parsing library for MRI Ruby
    spec.add_dependency 'rubyzip', '>= 1.0.0' # will load new rubyzip version
    spec.add_dependency 'grape'
    spec.add_dependency 'grape-entity'

    spec.add_dependency 'sidekiq'

    # In spec.add_dependency hell migrating to RubyZip v1.0.0? Include zip-zip in your Gemfile and everything's coming up roses!
    # для axlsx
    spec.add_dependency 'zip-zip'

    spec.add_development_dependency "bundler", "~> 1.16"
    spec.add_development_dependency "rake", "~> 10.0"
    spec.add_development_dependency "rspec", "~> 3.0"
    spec.add_development_dependency 'rubocop'
    spec.add_development_dependency 'rubocop-rspec'
    spec.add_development_dependency 'guard-bundler'
    spec.add_development_dependency 'guard-ctags-bundler'
    spec.add_development_dependency 'guard-rspec'
    spec.add_development_dependency 'guard-rubocop'
    spec.add_development_dependency 'byebug'
    spec.add_development_dependency 'pry'
    spec.add_development_dependency 'pry-doc'
    spec.add_development_dependency 'pry-rails'
    spec.add_development_dependency 'pry-byebug'
    spec.add_development_dependency 'factory_bot'
    spec.add_development_dependency 'factory_bot_rails'
    spec.add_development_dependency 'rspec-rails', '~> 3.7'
    spec.add_development_dependency 'database_rewinder'
    spec.add_development_dependency 'mysql2'
    spec.add_development_dependency 'vcr'
    spec.add_development_dependency 'webmock'
    spec.add_development_dependency 'timecop'
    spec.add_development_dependency 'yard'
    spec.add_development_dependency 'yard-rspec'
end
