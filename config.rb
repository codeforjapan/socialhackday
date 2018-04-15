
activate :directory_indexes

set :relative_links, true
set :haml, { format: :html5 }

config[:timezone_offset] = '+0900'
set :site_name, 'Social Hack Day'
set :site_title, 'Social Hack Day'

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

# custom helpers
helpers do
  # show localized date
  def local_datetime(datestring)
    dt = DateTime.parse(datestring)
    offset = config[:timezone_offset] || '+0900'
    dt.new_offset(offset).strftime("%Y年%m月%d日")
  end
  def event_time_from_to(event)
    offset = config[:timezone_offset] || '+0900'
    start_time = DateTime.parse(event.event_start).new_offset(offset)
    end_time = DateTime.parse(event.event_end).new_offset(offset)
    # if the day is same, show time only
    if (start_time.year == end_time.year && start_time.mon == end_time.mon && start_time.mday == end_time.mday)
      start_time.strftime("%Y年%m月%d日 %H:%M") + "〜" + end_time.strftime("%H:%M")
    else
      start_time.strftime("%Y年%m月%d日 %H:%M") + "〜" + end_time.strftime("%Y年%m月%d日 %H:%M")
    end
  end
end
activate :relative_assets
