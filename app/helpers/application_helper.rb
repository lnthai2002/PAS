module ApplicationHelper
  #Overide default image_tag to fall back to error image to avoid compiled blank image not found in production 
  def image_tag(source, options={})
    source = "image_not_available.png" if source.blank?
    super(source, options)
  end

  def decorate_menu(menu_item)
    return link_to_unless_current(menu_item['text'], menu_item['path']) do
      content_tag(:span, menu_item['text'], :class => 'current')
    end
  end
end
