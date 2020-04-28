require 'open-uri'
require 'mini_magick'

namespace :images do
  task migrate: :environment do
    STDOUT.puts 'Migrating started...'

    Composition.find_each do |c|
      begin
        next if c.image.attached?
        next unless c.img_file_name.present?

        file = File.open URI.open(c.img.url)
        attachable = ImageProcessing::MiniMagick.source(file).call
        c.image.attach(
          io: attachable,
          filename: c.img_file_name
        )
        ImageProcessingJob.perform_later(c.id, c.class.name)
        c.touch
        print '.'
      rescue => e
        puts "Error with processing composition ##{c.id}: #{e}"
        c.destroy
        next
      end
    end

    Product.find_each do |c|
      begin
        next if c.image.attached?
        c.set_image unless c.img_file_name.present?
        attachable = URI.open(c.img.url)
        c.image.attach(
          io: attachable,
          filename: c.img_file_name
        )
        ImageProcessingJob.perform_later(c.id, c.class.name)
        c.touch
        print '.'
      rescue => e
        puts "Error with processing product ##{c.id}: #{e}"
        next
      end
    end

    STDOUT.puts 'Migrating ended..'
  end
end
