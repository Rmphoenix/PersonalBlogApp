module ApplicationHelper
  def full_title(title)
    default_title = "DIY Blog App Using Rails"
    if title.empty?
      default_title
    else
      "#{default_title} | #{title}"
    end
  end
  
  def path_find(page)
    if page == "new_user"
      return "/new_user"
    else
      "/home"
    end
  end
    
end
