require 'spec_helper'
require 'best_change/row'

RSpec.describe BestChange::PositionService, type: :services do
  include Mathematic

	let(:br_data) { Oj.load(File.read 'spec/fixtures/bestchange.json').each_with_index { |row, index| row.position = index }  }

  let(:br_rate) { br_data.find { |d| d.is_my? }.rate }

  # Рейт из bestchange data
  let!(:current_rate)       { Rate.new in_amount: 640307.14285714, out_amount: 1.0 }
  let!(:currency_pair)      { CurrencyPair.new RUB, BTC }
  let(:payment_system_from) { create :payment_system, type_cy: currency_pair.first.local_id } # RUB
  let(:payment_system_to)   { create :payment_system, type_cy: currency_pair.second.local_id } # BTC
  let(:direction)           { Direction.new payment_system_from: payment_system_from, payment_system_to: payment_system_to }

  # (СберОнлайн->Bitcoin)
  let!(:bestchange_key) { '42-93' }
  let!(:base_rate) { calculate_base_rate br_rate, comission }
  # let!(:base_rate)      { 1.7370546342914202e-06 }
  let(:comission)       { 10 }
  let!(:currency_rate)  { create :currency_rate, rate_value: base_rate, currency_pair: currency_pair }

  let!(:direction_rate_snapshot) { create :direction_rate_snapshot }

  let!(:exchange_rate) {
    ExchangeRate.find_by(payment_system_from: direction.payment_system_from, payment_system_to: direction.payment_system_to) ||
    create(:exchange_rate, payment_system_to: direction.payment_system_to, payment_system_from: direction.payment_system_from)
  }

  let!(:direction_rate) {
    direction_rate_snapshot.direction_rates.create(
      direction: direction,
      exchange_rate: exchange_rate,
      currency_rate: currency_rate,
      base_rate_value: base_rate
    )
  }

  let(:status) {
    BestChange::Service.
      new(exchange_rate: exchange_rate).
      status
  }

  let(:current_position) { 40 }

  before do
    exchange_rate.update comission: comission
    allow_any_instance_of(ExchangeRate).to receive(:validate_rate_bestchange_comission).and_return true
  end

  subject do
    BestChange::PositionService.
      new(exchange_rate: exchange_rate)
  end


  context 'проверочка' do
    it { expect(direction_rate.rate_value).to eq br_rate }
    it { expect(direction_rate.base_rate_value).to eq base_rate }
    it { expect(direction_rate.comission).to eq comission }
    it { expect(status.position).to eq current_position }
    it { expect(status.target_position).to eq current_position }
  end

  before do
    allow_any_instance_of(BestChange::Repository).to receive(:getRows).and_return br_data
  end

  describe 'курс выше 1 (RUB -> BTC)' do
    context 'Поднимаем выше' do
      let(:new_position) { 35 }

      specify do
        Sidekiq::Testing.inline! do
          subject.change_position! new_position
        end
        expect(status.target_position).to eq new_position
      end
    end

    context 'Поднимаем выше, где между строчками растояние мешьне чем наш шаг' do
      let(:new_position) { 3 }

      specify do
        Sidekiq::Testing.inline! do
          subject.change_position! new_position
        end
        expect(status.target_position).to eq new_position
      end
    end

    context 'Ставим как было' do
      let(:new_position) { current_position }

      specify do
        Sidekiq::Testing.inline! do
          subject.change_position! new_position
        end
        expect(status.target_position).to eq new_position
      end
    end

    context 'Опускаем ниже' do
      let(:new_position) { 41 }

      specify do
        Sidekiq::Testing.inline! do
          subject.change_position! new_position
        end
        expect(status.target_position).to eq new_position
      end
    end

    context 'Ставим первой' do
      let(:new_position) { 0 }

      specify do
        Sidekiq::Testing.inline! do
          subject.change_position! new_position
        end
        expect(status.target_position).to eq new_position
      end
    end

    context 'Ставим последней' do
      let(:new_position) { br_data.count - 1 }

      specify do
        Sidekiq::Testing.inline! do
          subject.change_position! new_position
        end
        expect(status.target_position).to eq new_position
      end
    end

    context 'Ставим ниже количества' do
      specify do
        Sidekiq::Testing.inline! do
          subject.change_position! br_data.count + 5
        end
        expect(status.target_position).to eq br_data.count - 1
      end
    end
  end
end
