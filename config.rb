
activate :directory_indexes

set :relative_links, true
set :haml, { format: :html5 }

config[:timezone_offset] = '+0900'

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
  # return event time of start and end
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
  # return <span> instead of <div> for simple_format
  def simple_format_with_span(text)
    simple_format(text, :tag => :span)
  end
  # return numbers of events
  def get_statistics(events)
    ret = {
      :spent_time => 0,
      :count_of_event => 0,
      :attendees => 0,
      :total_spent_time => 0,
      :number_of_projects => 0
    }
    events.each do |e|
      start_time = DateTime.parse(e.event_start)
      end_time = DateTime.parse(e.event_end)
      next if end_time > DateTime.now()
      ret[:count_of_event] += 1
      ret[:spent_time] += ((end_time - start_time) * 24).to_i
      ret[:attendees] += e.attendees.to_i
      ret[:number_of_projects] += e.number_of_projects.to_i
      ret[:total_spent_time] += (e.attendees.to_i * ((end_time - start_time) * 24)).to_i
    end
    ret
  end
end
activate :relative_assets
