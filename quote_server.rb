require "sinatra"
require "yaml"
require "tilt/erubis"
require "colorist"

quotes = YAML.load_file("quotes.yml")

# Renders an HTML page that's linked to the
# `projector.css` stylesheet.
get "/" do
  @quote = quotes.sample
  erb :index
end

# A dynamically generated stylesheet that grabs the `Slide-Background-Color` and
# `Slide-Foreground-Color` headers to style the contents of the index page to
# more closely match the presenters theme.
get "/projector.css" do
  @background = color_header "HTTP_SLIDE_BACKGROUND_COLOR", default: "#ffffff"
  @foreground = color_header "HTTP_SLIDE_FOREGROUND_COLOR", default: "#000000"
  headers["Content-Type"] = "text/css"
  erb :projector
end

# Validate the color inputs to make sure they're actually
# colors, and not some other string.
def color_header(key, default: "#ffffff")
  Colorist::Color.from_string(env[key])
rescue
  Colorist::Color.from_string(default)
end
