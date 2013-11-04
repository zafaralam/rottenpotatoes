module ApplicationHelper
  def sortable(column, title = nil)
    title ||= coulmn.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    css_class = (column == sort_column) ? "hilite" : nil
    content_tag(:th, link_to(title, {:sort => column, :direction => direction}, {:id => "#{column}_header"}), :class => css_class)
  end
end
