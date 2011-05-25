module ApplicationHelper
  def error_messages_for(resource)
    return if resource.errors.blank?

    items = resource.errors.full_messages.map do |error|
      content_tag(:li, error)
    end    
    raw content_tag(:ul, raw(items))
  end
end
