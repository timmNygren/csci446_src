#!/usr/bin/ruby

require 'rack'
require 'CSV'

class SimpleApp
	def initialize()
    # can set up variables that will be needed later
    @bookList = []
    load_books
		@time = Time.now
	end

	def call(env)
    # create request and response objects
		request = Rack::Request.new(env)
		response = Rack::Response.new
    # include the header
		File.open("header.html", "r") { |head| response.write(head.read) }
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
        [404, {"Content-Type" => "text/plain"}, ["Error 404!"]]
    end	# end case
      render_footer(request, response)
      response.finish
  end

  # try http://localhost:8080/form
	def render_form(req, response)
    File.open("_form.html", "r") { |head| response.write(head.read)}
	end

  # try http://localhost:8080/list?sortorder=Author
	def render_list(req, response)
		sortorder = req.GET["sortorder"]
    case sortorder
    when "Title"
      sort = :title
    when "Author"
      sort = :author
    when "Language"
      sort = :language
    when "Year"
      sort = :year
    else
      puts "An error with sort selections."
      sort = :title
    end
    response.write("<h2>Sorted by #{sort}</h2>")
    @bookList.sort! { |book1, book2| book1[sort] <=> book2[sort]}
    render_table(req, response, sort)
	end

  def render_footer(req, response)
    response.write("<footer><br /><small>Brought to you by: We Grok Books</small></footer>")
  end

  def render_table(req, response, sort)
    response.write("<table>")
    response.write("<tr>")
    response.write("<th>Rank</th>")
    response.write("<th>Title</th>")
    response.write("<th>Author</th>")
    response.write("<th>Language</th>")
    response.write("<th>Year</th>")
    response.write("<th>Copies</th>")
    response.write("</tr>")
    @bookList.each do |book|
      response.write("<tr>")
      book.each do |attribute|
        if (attribute[0] == sort)
          response.write("<td id='sort'>#{attribute[1]}")
        else
          response.write("<td>#{attribute[1]}")
        end
      end
      response.write("</tr>")
    end
    response.write("</table>")
  end

  def load_books
    counter = 1
    CSV.foreach("bookList.csv") do |row|
      tempItem = {:rank => counter, :title => row[0], :author => row[1], :language => row[2], :year => row[3], :copies => row[4]}
      @bookList << tempItem  
      counter += 1
    end
  end
end


Signal.trap('INT') {
	Rack::Handler::WEBrick.shutdown
}

Rack::Handler::WEBrick.run SimpleApp.new, :Port => 8080
