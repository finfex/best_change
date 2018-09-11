require 'oj'

# Класс нужно предварительно загрузить, чтобы Oj его использовал
require_relative 'row'

# Репозиторий bestchange-евских рейтингов
#
module BestChange
  class Repository < RedisRepository
    KEY_SEPARATOR = '-'.freeze

    class << self
      delegate :getRows, :setRows, :getRowByExchangerId, to: :instance

      # Идентификаторы платежных систем в bestchange
      def generate_key_from_bestchange_ids(id1, id2)
        [id1, id2].join KEY_SEPARATOR
      end
    end

    # key - ключ вида ID1_ID2
    # где ID1, ID2 - идентификаторы направления обмена из BestExchange (PaymentSystem#bestchange_id)
    # возвращает список BestChange::Row
    def getRows(key)
      value = get key
      return [] unless value.present?
      Oj.load(value).each_with_index { |row, index| row.position = index }
    end

    def setRows(key, data)
      set key, Oj.dump(data)
    end

    # TODO rename to getRowByKey
    def getRowByExchangerId(key, exchanger_id = nil)
      exchanger_id ||= BestChange.configuration.exchanger_id

      getRows(key).find { |row| row.exchanger_id == exchanger_id}
    end
  end
end
