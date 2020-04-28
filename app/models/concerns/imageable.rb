module Imageable
  extend ActiveSupport::Concern
  included do
    include Rails.application.routes.url_helpers
    has_one_attached :image
    after_create_commit { ImageProcessingJob.perform_later(id, self.class.name) }
  end

  def self.default_scope
    with_attached_image
  end

  def missing(key)
    ActionController::Base.helpers.asset_path("missing_#{key}.png")
  end

  def small_url
    return missing(:small) unless image.attached?
    process_variant(variants[:small]).service_url.split('?').first
  end

  def medium_url
    return missing(:medium) unless image.attached?
    process_variant(variants[:medium]).service_url.split('?').first
  end

  def large_url
    return missing(:large) unless image.attached?
    process_variant(variants[:large]).service_url.split('?').first
  end

  def process_variant(variant)
    image.variant(
      variant[:process] => [variant[:width], variant[:height]],
      auto_orient: true,
      strip: true,
      gravity: 'center',
      quality: '100%'
    )
  end
end
