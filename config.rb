# Custom MD parser
class ExtraSpecialParser < Redcarpet::Render::HTML

  # def preprocess(document)
  #   puts document
  #   document
  # end

  # def normal_text(text)
  #   puts text
  #   text
  # end

  def paragraph(text)
    "<p>
      #{ text.gsub('--', '&mdash;') }
    </p>"
  end

  def header(text, header_level)
    if header_level == 2
      slug = text.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      "<h2 class='section-title' id=#{ slug }><a href='##{slug}' class='section-inner'>#{ text }</a></h2>"
    else
      "<h#{ header_level } tabIndex=0>#{ text }</h#{ header_level }>"
    end
  end

  def block_quote(text)
    parts = text.split(' --');
    quote = parts[0];
    quoteSource = parts[1];
    "
      <blockquote>
        #{quote}
        <cite>
          #{quoteSource}
        </cite>
      </blockquote>
    "
  end

  def block_code(code, language)
    Middleman::Syntax::Highlighter.highlight(code, language, css_class: 'code', line_numbers: false)
  end
  #
  # def list(contents, list_type)
  #   @tag = list_type[0] == 'o' ? 'ol' : 'ul'
  #   "<span class='article-p-inner'>
  #     <#{@tag} class='article-list'>
  #       #{contents}
  #     </#{@tag}>
  #   </span>"
  # end

end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '/404.html', layout: false, :directory_index => false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
page '/info.html', :layout => "article"

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

activate :blog do |blog|
  ignore '*.ignore*'
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  blog.permalink = "{title}.html"
  # Matcher for blog source files
  blog.sources = "articles/{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  blog.layout = "article"
  blog.new_article_template = File.expand_path('../source/sample-article.tt', __FILE__)
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  blog.default_extension = ".md.erb"

  # blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  activate :livereload
  activate :directory_indexes
  config[:js_dir] = 'js'
  config[:css_dir] = 'styles'
  config[:images_dir] = 'images'

  activate :syntax
  set :markdown_engine, :redcarpet
  set(
    :markdown,
    :fenced_code_blocks => true,
    :smartypants => true,
    :disable_indented_code_blocks => true,
    :strikethrough => true,
    :highlight => true,
    :renderer => ExtraSpecialParser.new(with_toc_data: true)
  )
  activate :minify_html
  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

page "/feed.xml", layout: false
# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
#   activate :directory_indexes
#   config[:js_dir] = 'js'
#   # config[:css_dir] = 'styles'
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css
  activate :gzip
  # Minify Javascript on build
  # activate :minify_javascript
end
