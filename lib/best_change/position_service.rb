class BestChange::PositionService
  include Virtus.model strict: true

  STEP = 0.005

  attribute :exchange_rate #, ::ExchangeRate

  def change_position!(new_position)
    return if rows.count == 0

    if my_row.present?
      return if new_position == my_row.status.target_position
      new_position += 1 if new_position > my_row.status.target_position
    end

    if new_position >= rows.count
      row = rows.last
      return if row.is_my?
      comission  = row.base_rate_percent + STEP
    else
        # TODO убеждаться что не стали выше предыдущего
      row = rows[new_position]
      return if row.is_my?

      step = STEP
      if new_position > 0
        previous_comission = rows[new_position-1].base_rate_percent
        step = (row.base_rate_percent - previous_comission)/2.0 if row.base_rate_percent - previous_comission < step
      end
      comission  = row.base_rate_percent - step
    end

    exchange_rate.update! comission: comission
  end

  private

  delegate :rows, :my_row, to: :service

  def service
    @service ||= BestChange::Service.
      new(exchange_rate: exchange_rate)
  end
end
