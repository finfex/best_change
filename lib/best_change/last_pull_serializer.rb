require 'fast_jsonapi'

module BestChange
  class LastPullSerializer
    include ::FastJsonapi::ObjectSerializer
    set_type :bestchange_last_pull

    attributes :at, :elapsed_seconds
  end
end
