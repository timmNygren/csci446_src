module ApplicationHelper

  def sortable(column, title = nil)
  	title ||= column.titleize
  	css_class = column == sort_column ? "current #{sort_direction}" : nil
  	direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  	link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def hidden_div_if(condition, attributes = {}, &block)
  	if condition
  		attributes["style"] = "display: none"
  	end
  	content_tag("div", attributes, &block)
  end
end
