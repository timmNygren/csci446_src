#!/usr/bin/ruby

require 'rack'
require 'CSV'
require 'ERB'
require 'sqlite3'

class SimpleApp
	def initialize()
    # can set up variables that will be needed later
    @db = SQLite3::Database.new( "books.sqlite3.db")
    @validParams = ["id", "title", "author", "language", "published"]
	end

	def call(env)
    # create request and response objects
		request = Rack::Request.new(env)
		response = Rack::Response.new
		case env["PATH_INFO"]
      when /.*?\.css/
        # serve up a css file
        # remove leading /
        file = env["PATH_INFO"][1..-1]
        return [200, {"Content-Type" => "text/css"}, [File.open(file, "rb").read]]
      when /\/form.*/
        # serve up the form
        render_form(request, response)
      when /\/list.*/
        # serve up a list response
        render_list(request, response)
      else
        return [404, {"Content-Type" => "text/plain"}, ["Error 404!"]]
    end	# end case
      response.finish
  end

  # try http://localhost:8080/form
	def render_form(req, response)
    render_page(req, response, "form.html.erb")
	end

  # try http://localhost:8080/list?sortorder=Author
	def render_list(req, response)
    # Check for our sort order
		if !req.GET["sortorder"]
      @sort = "title"
    else
      @sort = req.GET["sortorder"]
    end
    # Check the sort to make sure it's valid
    # If user messes with added param, sort order is 
    # default to 'title' to protect database query
    if !@validParams.include? @sort
      @sort = "title"
    end

    # sortorder to use to display chosen option back instead of 'id' or 'published'
    case @sort
      when "id"
        @sortorder = "rank"
      when "published"
        @sortorder = "published date"
      else
        @sortorder = @sort
    end
    # Get our list
    @bookList = @db.execute( "select * from books order by #{@sort}")
    # Render the page
    render_page(req, response, "list.html.erb")
	end

  def render_page(req, response, page)
    response.write(ERB.new(File.read(page)).result(binding))
  end
end

Signal.trap('INT') {
	Rack::Handler::WEBrick.shutdown
}

Rack::Handler::WEBrick.run SimpleApp.new, :Port => 8080
