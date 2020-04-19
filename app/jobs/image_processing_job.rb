class ImageProcessingJob < ApplicationJob

  def perform(id)
    composition = Composition.find_by(id: id)
    return unless composition.present? && composition.image.attached?

    raise StandardError.new('Image did not analyzed yet') unless composition.image.analyzed?

    attach_watermark!(composition) unless composition.image.filename =~ /watermarked/

    composition.image.attach(
      io: @watermarked_image,
      filename: ( 'watermarked_' + composition.image.filename.to_s)
    )

    Composition::VARIANTS.each do |_, variant|
      composition.process_variant(variant).processed
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
