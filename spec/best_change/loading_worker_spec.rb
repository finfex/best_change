require 'spec_helper'

RSpec.describe BestChange::LoadingWorker do
  it do
     VCR.use_cassette :bestchange do
       expect(BestChange::LoadingWorker.new.perform).to eq 5918
     end
  end
end
