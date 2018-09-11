class BestChange::StatusSerializer
  include FastJsonapi::ObjectSerializer

  set_type :best_change_status

  attributes :position, :state, :target_type, :target_position,
    :target_base_percent_rate, :bestchange_base_percent_rate
end
