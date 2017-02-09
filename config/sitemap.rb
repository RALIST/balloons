# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://bigairballoons.ru"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
                                         aws_access_key_id: ENV['AWS_ACCESS_KEY'],
                                         aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                         fog_directory: ENV['AWS_BUCKET'],
                                         fog_region: ENV['AWS_REGION'])
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_host = "http://s3.amazonaws.com/flashcards123"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  Composition.find_each do |c|
    add composition_path(c)
  end

  Tag.find_each do |tag|
    add search_path(tag_name: tag.name)
  end

  Receiver.find_each do |r|
    add with_receivers_path(q: r.title)
  end


end
