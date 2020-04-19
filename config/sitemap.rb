# Set the host name for URL creation

require 'aws-sdk'

SitemapGenerator::Sitemap.default_host = 'https://bigairballoons.ru'
if Rails.env.production?
  SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(ENV['AWS_BUCKET'],
                                                                      aws_access_key_id: ENV['AWS_ACCESS_KEY'],
                                                                      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                                                      aws_region: ENV['AWS_REGION'])
  SitemapGenerator::Sitemap.public_path = 'tmp/'
  SitemapGenerator::Sitemap.sitemaps_host = 'https://s3.eu-central-1.amazonaws.com/balloons-images'
  SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
  SitemapGenerator::Sitemap.compress = false
end

SitemapGenerator::Sitemap.create do
  Composition.availible.find_each do |c|
    add composition_path(c, city: nil), lastmod: c.updated_at
  end

  add tags_path

  Tag.composition_tags.each do |tag|
    add tag_path(tag, city: nil), lastmod: tag.updated_at
    Composition.availible.with_tag(tag.name).each do |c|
      add tag_composition_path(tag, c, city: nil)
    end
  end

  add receivers_path(city: nil)

  Receiver.all.select('distinct on (title) *').each do |r|
    add receiver_path(r, city: nil)
    Composition.with_receivers(r.title).availible.each do |c|
      add receiver_composition_path(r, c, city: nil)
    end
  end

  Color.all.each do |color|
    add color_path(color, city: nil), lastmod: color.updated_at
  end

  Subcategory.joins(items: [:type, :sizes])
              .where('types.name = ? OR types.name = ?', 'латексные шары', 'фольгированные шары')
              .distinct.each do |category|
    add category_path(category, city: nil), lastmod: category.updated_at
  end


  add colors_path(city: nil)
  add categories_path(city: nil)
  add products_path(city: nil)
  add partners_path(city: nil)
  add prices_path(city: nil)
  add contacts_path(city: nil)
  add info_path(city: nil)
  add garant_path(city: nil)
  add about_path(city: nil)
  add business_index_path(city: nil)
  add feedbacks_path(city: nil)
  add faq_path(city: nil)
end
