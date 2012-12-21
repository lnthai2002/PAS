module ApplicationHelper
  def decorate_menu(menu_item)
    return link_to_unless_current(menu_item['text'], menu_item['path']) do
      content_tag(:span, menu_item['text'], :class => 'current')
    end
  end
end
