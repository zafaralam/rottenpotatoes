module ApplicationHelper
  def sortable(column, title = nil)
    # setting the title to the column name if title is empty
    title ||= coulmn.titleize
    # setting the default direction of to desc if direction is empty
    direction = (column == session[:sort_column] && session[:sort_direction] == "asc") ? "desc" : "asc"
    # adding the css class for the th tag
    css_class = (column == session[:sort_column]) ? "hilite" : nil
    content_tag(:th, link_to(title, {:sort => column, :direction => direction}, {:id => "#{column}_header"}), :class => css_class)

  end
end
