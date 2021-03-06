class ImageProcessingJob < ApplicationJob

  def perform(id, class_name)

    obj = class_name.constantize.find_by(id: id)
    return unless obj.present?

    raise StandardError.new('Image did not analyzed yet') unless obj.image.analyzed?

    unless obj.image.filename =~ /watermarked/ || class_name == 'Product' || obj.image.attached?
      attach_watermark!(obj)

      obj.image.attach(
        io: @watermarked_image,
        filename: ( 'watermarked_' + obj.image.filename.to_s)
      )
    end

    obj.variants.each do |_, variant|
      obj.process_variant(variant).processed
    end
  end

  def attach_watermark!(composition)
    composition.image.open do |image|
      watermark_path = Rails.root.join('app/assets/images/logo-shop.png')
      watermark = ImageProcessing::MiniMagick
                    .source(watermark_path)
                    .resize_to_limit(composition.image.metadata[:width].to_i / 2, nil, sharpen: false)
                    .define(png: { format: 'png00' })
                    .quality('100')
                    .call
      @watermarked_image = ImageProcessing::MiniMagick
                             .source(image)
                             .composite(watermark,
                                        mode: 'over',
                                        gravity: 'north-east',
                                        offset: [20, 20])
                             .composite(watermark,
                                        mode: 'over',
                                        gravity: 'south-west',
                                        offset: [20, 20])
                             .call
    end
  end
end
