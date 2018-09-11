require 'spec_helper'

RSpec.describe BestChange::Record do
  let(:nan) { 1.0 / 0.0 - 1.0 / 0.0 }

  let!(:b1) {
    BestChange::Record.new(
      exchanger_id: 1,
      exchanger_name: 'test',
      buy_price: 1,
      sell_price: 2,
      reserve: 3,
      time: 1,
      position: 1,
      base_rate_percent: 0.1,
      target_rate_percent: nil
    )
  }
  let!(:b2) {
    BestChange::Record.new(
      exchanger_id: 2,
      exchanger_name: 'test',
      buy_price: 1,
      sell_price: 2,
      reserve: 3,
      time: 1,
      position: 1,
      base_rate_percent: 0.1,
      target_rate_percent: 1
    )
  }
  let!(:b3) {
    BestChange::Record.new(
      exchanger_id: 3,
      exchanger_name: 'test',
      buy_price: 0,
      sell_price: 0,
      reserve: 3,
      time: 1,
      position: 1,
      base_rate_percent: 0,
      target_rate_percent: 0
    )
  }
  let!(:b4) {
    BestChange::Record.new(
      exchanger_id: 3,
      exchanger_name: 'test',
      buy_price: 0,
      sell_price: 0,
      reserve: 3,
      time: 1,
      position: 1,
      base_rate_percent: nan,
      target_rate_percent: nan
    )
  }
  it 'не падает ошибка при попытке сортировки если один из target_rate_percent=nil' do
    # ArgumentError: comparison of BestChange::Record with BestChange::Record failed
    expect {
      [b1, b2, b3, b4].sort
    }.to_not raise_error
  end
end
