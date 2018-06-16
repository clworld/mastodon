# frozen_string_literal: true

module Mastodon
  module Version
    module_function

    def major
      2
    end

    def minor
      4
    end

    def patch
      2
    end

    def pre
      nil
    end
	
    class << self
      alias_method :original_minor, :minor
      alias_method :original_patch, :patch
    end
    @@minor = nil
    def minor
      @@minor = !ENV['VERSION_MINOR'].nil? ? ENV['VERSION_MINOR'] : nil if @@minor.nil?
      !@@minor.nil? ? @@minor : original_minor
    end
    @@patch = nil
    def patch
      @@patch = !ENV['VERSION_PATCH'].nil? ? ENV['VERSION_PATCH'] : nil if @@patch.nil?
      !@@patch.nil? ? @@patch : original_patch
    end

    @@append_version = nil
    def append_version
    @@append_version = ENV['APPEND_VERSION'].present? ? ENV['APPEND_VERSION'] : '' if @@append_version.nil?
      @@append_version
    end

    def flags
      'rc1'
    end

    def to_a
      [major, minor, patch, pre].select { |v| v.present? }
    end

    def to_s
      append = append_version.present? ? " #{append_version}" : ''
      [to_a.join('.'), flags, append].join
    end

    def source_base_url
      'https://github.com/clworld/mastodon'
    end

    # specify git tag or commit hash here
    def source_tag
      nil
    end

    def source_url
      if source_tag
        "#{source_base_url}/tree/#{source_tag}"
      else
        source_base_url
      end
    end

    def user_agent
      @user_agent ||= "#{HTTP::Request::USER_AGENT} (Mastodon/#{Version}; +http#{Rails.configuration.x.use_https ? 's' : ''}://#{Rails.configuration.x.web_domain}/)"
    end
  end
end
