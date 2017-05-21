# frozen_string_literal: true

module Mastodon
  module Version
    module_function

    def major
      1
    end

    def minor
      4
    end

    def patch
      0
    end

    def pre
      2
    end
	
	class << self
	  alias_method :original_patch, :patch
	end
	@@patch = nil
	def patch
	  @@patch = ENV['VERSION_PATCH'].present? ? ENV['VERSION_PATCH'] : '' if @@patch.nil?
	  @@patch.present? ? @@patch : original_patch
	end

	@@append_version = nil
    def append_version
	  @@append_version = ENV['APPEND_VERSION'].present? ? ENV['APPEND_VERSION'] : '' if @@append_version.nil?
      @@append_version
    end

    def to_a
      [major, minor, patch, pre].select { |v| v.present? }
    end

    def to_s
	  append = append_version.present? ? " #{append_version}" : ''
      to_a.join('.') + append
    end
  end
end
