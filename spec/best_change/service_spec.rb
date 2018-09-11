require 'spec_helper'
require 'best_change/row'

RSpec.describe BestChange::Service, type: :services do
  let!(:currency_rate) { create :currency_rate }
  let!(:rows) {
    [
      BestChange::Row.new(
        exchanger_id: 1,
        exchanger_name: 'test',
        buy_price: 1.0,
        sell_price: 1.2,
        reserve: 123.12,
        time: 0,
        position: 0
      ),
      BestChange::Row.new(
        exchanger_id: 2,
        exchanger_name: 'test2',
        buy_price: 1.10,
        sell_price: 1.12,
        reserve: 120.12,
        time: 0,
        position: 1
      )
    ]
  }
  let!(:exchange_rate) { create :exchange_rate }

  subject { BestChange::Service.new exchange_rate: exchange_rate }

  it do
    expect(BestChange::Repository).to receive(:getRows).and_return rows

    expect(subject.rows).to be_a Array
    expect(subject.rows.count).to eq rows.count
  end
end
