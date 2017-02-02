# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://bigairballoons.ru"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

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
