require 'virtus'

module BestChange
  class LastPull
    include ::Virtus.model strict: true

    attribute :at, Time

    def id
      :bestchange_last_pull
    end

    def initialize
      super at: File.mtime(BestChange.configuration.valuta_access_log)
    end

    def elapsed_seconds
      Time.zone.now - at
    end
  end
end
