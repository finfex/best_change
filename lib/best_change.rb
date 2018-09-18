require 'gera'

require "best_change/version"
require "best_change/redis_repository"
require "best_change/last_pull"
require "best_change/last_pull_serializer"
require "best_change/loading_worker"
require "best_change/position_service"
require "best_change/record"
require "best_change/repository"
require "best_change/row"
require "best_change/row_serializer"
require "best_change/service"
require "best_change/status_entity"
require "best_change/status"
require "best_change/status_serializer"
require "best_change/configuration"

module BestChange
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
