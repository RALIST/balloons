# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://bigairballoons.ru"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
                                         aws_access_key_id: ENV['AWS_ACCESS_KEY'],
                                         aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                         fog_directory: ENV['AWS_BUCKET'],
                                         fog_region: ENV['AWS_REGION'])
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-us-west-2.amazonaws.com/flashcards123"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do

  Composition.availible.find_each do |c|
    add composition_path(c)
  end

  Tag.find_each do |tag|
    add by_tag_path(tag.name)
  end

  Receiver.find_each do |r|
    add person_path(r.title)
  end

  prices = Composition.availible.pluck(:price)
  prices.length.times do
    min = prices[rand(prices.length)]
    max = prices[rand(prices.length)]
    if min < max
      add price_range_path(min: min, max: max)
    end
  end

  prices.each do |p|
    add price_range_path(min: p)
    add price_range_path(max: p)
  end

  add '/prices'
  add '/contacts'
  add '/lp'

end
