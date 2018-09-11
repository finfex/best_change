require_relative 'status'
require 'grape'
require 'grape-entity'

module BestChange
  class StatusEntity < ::Grape::Entity
    expose :position, documentation: { type: 'integer', desc: 'Позиция обменника в списке', required: true }
    expose :target_type, documentation: { type: 'string', desc: 'Вид цели (комиссия или позиция)', values: Status::TARGETS, required: true }
    expose :status, documentation: { type: 'string', desc: 'Состояние обменника в соответсвии с целью', values: Status::STATES, required: true }
    expose :target_base_percent_rate, documentation: { type: 'float', desc: 'Целевая комиссия относительно текущей базовой ставки (%)', required: true }
    expose :bestchange_base_percent_rate, documentation: { type: 'float', desc: 'Комиссия относительно текущей базовой ставки от bestchange (%)', required: true }
  end
end
