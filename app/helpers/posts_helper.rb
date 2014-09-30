module PostsHelper
  def field_with_errors(object,field)
    if object.errors[field].empty?
      text_field_tag field
    else
      error = content_tag(:div, :class=>"error") do
        object.class.name + " " + object.errors[field].first
      end
      error + text_field_tag(field)
    end
  end
end
