require 'singleton'
require 'active_support/core_ext/module'

class BestChange::RedisRepository
  include ::Singleton

  class << self
    delegate :get, :set, :keys, to: :instance
  end

  delegate :get, :set, :keys, to: :store

  def initialize(ns = nil)
    @ns = ns
  end

  private

  def store
    @store ||= ::Redis::Namespace.new(
      @ns ||= self.class.to_s.underscore,
      redis: ::Redis.new(::BestChange.configuration.redis)
    )
  end
end
