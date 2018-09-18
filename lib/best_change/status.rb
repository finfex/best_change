require 'gera/rate'
module BestChange
  class Status
    include Virtus.model strict: true

    attribute :id, String

    STATE_UNKNOWN = :unknown # unknown - не известен
    STATE_ACTUAL  = :actual # позиция на bestchange соответсвует заявленной
    STATE_AWAIT   = :awaiting # ожидаем когда bestchange установит нашу позицию

    STATES = [ STATE_UNKNOWN, STATE_ACTUAL, STATE_AWAIT]

    attribute :state, Symbol, default: :unknown

    TARGETS = [:rate, :position]
    attribute :target, Symbol, default: :rate

    # Целевая комиссия относительной базовой ставки
    attribute :target_base_percent_rate, Float
    attribute :bestchange_base_percent_rate # Nil or Float

    # Текущая позиция в bestchange
    attribute :position, Integer

    # Целевая позиция в bestchange
    attribute :target_position, Integer

    attribute :finite_rate, Gera::Rate
  end
end
