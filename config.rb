activate :directory_indexes

set :relative_links, true
set :haml, { format: :html5 }

# Disable Haml warnings
Haml::TempleEngine.disable_option_validator!

page "/*.xml", layout: false
page "/*.json", layout: false
page "/*.txt", layout: false
page "/404.html", directory_index: false

set :css_dir, "assets/stylesheets"
set :images_dir, "assets/images"
set :js_dir, "assets/javascripts"


activate :data_source do |c|
  c.root  = "https://script.google.com/macros/s/AKfycbzykqG-CZmFsrLmUhSvpnE-V9iR0VQDxcfG_y-o-QHEtV3ghZu3"
  c.sources = [
    {
      alias: "projects",
      path: "/exec?type=projects",
      type: :json },
      {
        alias: "events",
        path: "/exec?type=events",
        type: :json },
  ]
end

configure :build do
  activate :external_pipeline,
    name: :gulp,
    command: "npm run production",
    source: ".tmp",
    latency: 1

  ignore "assets/javascripts/all.js"
  ignore "assets/stylesheets/site"
  activate :gzip

  activate :minify_html do |html|
    html.remove_quotes = false
    html.remove_intertag_spaces = true
  end
end

# import vendor path in case `middleman server`
configure :development do
  import_path File.expand_path('lib/vendor', app.root)
end
# copy vendor path in case `middleman build`
after_build do |builder|
  FileUtils.cp_r 'lib/vendor', config[:build_dir]
end

activate :relative_assets
