require 'open-uri'

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
        ImageProcessingJob.perform_later(c.id)
        print '.'
      rescue => e
        puts "Error with processing composition ##{c.id}: #{e}"
        c.destroy
        next
      end
    end
    STDOUT.puts 'Migrating ended..'
  end
end
