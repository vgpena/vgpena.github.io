xml.instruct!
xml.rss version: '2.0',
  'xmlns:atom' => 'http://www.w3.org/2005/Atom',
  'xmlns:webfeeds' => 'http://webfeeds.org/rss/1.0' do
  site_url = "https://vgpena.github.io"
  xml.title "hey it's violet"
  xml.subtitle "developer & human in the PNW"
  xml.id URI.join(site_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(site_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(site_url, current_page.path), "rel" => "self"
  xml.updated(blog.articles.first.date.to_time.iso8601) unless blog.articles.empty?
  xml.author { xml.name "Violet Peña" }
  xml.image URI.join(site_url, 'images/default.png')
  xml.tag!('webfeeds:cover', image: URI.join(site_url, 'images/default.png'))
  xml.tag!('webfeeds:icon', image: URI.join(site_url, 'images/icon.svg'))
  xml.tag!('webfeeds:accentColor', '2710F2')

  blog.articles[0..5].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => URI.join(site_url, article.url)
      xml.id URI.join(site_url, article.url)
      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.author { xml.name "Violet Peña" }
      xml.summary article.metadata[:page][:summary], "type" => "html"
      xml.content article.body, "type" => "html"
      xml.tag!('webfeeds:cover', image: URI.join(site_url, 'images/', article.metadata[:page][:hero] || 'default.png'))
    end
  end
end
