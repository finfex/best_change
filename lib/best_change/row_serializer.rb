class BestChange::RowSerializer
  include FastJsonapi::ObjectSerializer
  set_type :bestchange_row

  attributes :exchanger_id, :exchanger_name, :buy_price, :sell_price, :reserve,
    :rate, :base_rate_percent, :position
  attributes :status
end
