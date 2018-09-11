class BestChange::Record
  include Virtus.model strict: true
  NULL_STUB = 9999

  attribute :exchanger_id,      Integer # ID обменнике по таблице BestExchange bm_exch.dat
  attribute :exchanger_name,    String  # Имя обменника
  attribute :buy_price,         Float   # BestExchange сумму назвают "отдаете"
  attribute :sell_price,        Float   # BestExchange называют "получите"
  attribute :reserve,           Float   # Резерв
  attribute :time,              Integer
  attribute :position,          Integer
  attribute :base_rate_percent, Float
  # Может быть nil, если у нас отсутвует котировка на этом направлении
  attribute :target_rate_percent # Nil or Float
  attribute :status #,            BestChange::Status

  def is_my?
    exchanger_id == BestChange.configuration.exchanger_id
  end

  def id
    exchanger_id
  end

  def <=>(other)
    t1 = self.target_rate_percent
    t1 = NULL_STUB if t1.nil? || (t1.is_a?(Float) && t1.nan?) || t1.infinite?

    t2 = other.target_rate_percent
    t2 = NULL_STUB if t2.nil? || (t2.is_a?(Float) && t2.nan?) || t2.infinite?

    t1 <=> t2
  end

  def rate
    sell_price / buy_price
  end
end
