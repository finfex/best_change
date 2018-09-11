class BestChange::Row
  include Virtus.model strict: true

  attribute :exchanger_id,   Integer # ID обменнике по таблице BestExchange bm_exch.dat
  attribute :exchanger_name, String  # Имя обменника
  attribute :buy_price,      Float   # BestExchange сумму назвают "отдаете"
  attribute :sell_price,     Float   # BestExchange называют "получите"
  attribute :reserve,        Float   # Резерв
  attribute :time,           Integer

  # Устанавливается при загрузке из репозитория
  attr_accessor :position

  def is_my?
    exchanger_id == BestChange.configuration.exchanger_id
  end

  # Для сериализатора
  def id
    exchanger_id
  end

  def <=>(other)
    other.rate <=> self.rate
  end

  def rate
    sell_price / buy_price
  end
end
