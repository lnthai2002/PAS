module ApplicationHelper
  def decorate_menu(url)
puts "------------------------ #{params[:controller]}"
    case params[:controller]
      when 'expenses', 'exp_types', 'payment_types'
        if url =~ /Financial/
          return '<p>-></p>' + url
        else
          return url
        end
      when 'songs'
        if url =~ /Music/
          return '<p>-></p>' + url
        else
          return url
        end
      when 'recipes', 'steps', 'ingredients'
        if url =~ /Cooking/
          return '<p>-></p>' + url
        else
          return url
        end
      else
        return url
    end
  end
end
