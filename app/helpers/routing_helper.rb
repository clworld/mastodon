# frozen_string_literal: true

module RoutingHelper
  extend ActiveSupport::Concern
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::AssetTagHelper
  include Webpacker::Helper

  included do
    def default_url_options
      ActionMailer::Base.default_url_options
    end
  end

  def full_asset_url(source, **options)
    if use_storage?
      URI.join(root_url, source).to_s
	else
	  asset_url = ActionController::Base.helpers.asset_url(source, options)
	  asset_url =~ /^http/ ? asset_url : URI.join(root_url, asset_url).to_s
	end
  end

  def full_pack_url(source, **options)
    full_asset_url(asset_pack_path(source, options))
  end

  private

  def use_storage?
    Rails.configuration.x.use_s3 || Rails.configuration.x.use_swift
  end
end
