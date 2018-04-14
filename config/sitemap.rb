# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://bigairballoons.ru'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
                                                                    aws_access_key_id: ENV['AWS_ACCESS_KEY'],
                                                                    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                                                    fog_directory: ENV['AWS_BUCKET'],
                                                                    fog_region: ENV['AWS_REGION'])
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_host = 'https://s3-us-west-2.amazonaws.com/flashcards123'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.create do
  Composition.availible.find_each do |c|
    add composition_path(c), lastmod: c.updated_at
  end

  Tag.composition_tags.each do |tag|
    add tag_path(tag), lastmod: tag.updated_at
    Composition.availible.with_tag(tag.name).each do |c|
      add tag_composition_path(tag, c)
    end
  end

  Receiver.all.select('distinct on (title) *').each do |r|
    add receiver_path(r)
    Composition.with_receivers(r.title).availible.each do |c|
      add receiver_composition_path(r, c)
    end
  end

  add partners_path
  add prices_path
  add contacts_path
  add info_path
  add garant_path
  add about_path
  add business_index_path
  add feedbacks_path
  add 'graduations/sadik'
  add 'graduations/shkola'
  add faq_path
end
