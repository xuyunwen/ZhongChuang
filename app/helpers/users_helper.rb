module UsersHelper
  def has_permission?(permission)


  end

  def header_tag(user)
    if user and user.header
      "<img class='header' src='#{user.header}'> alt='#{user.name}'".html_safe
    else
      image_tag 'default_header.jpg', class: 'header', alt: user.name
    end
  end
end
