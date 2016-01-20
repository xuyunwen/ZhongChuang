module UsersHelper

  def header_tag(user)
    if user and user.header
      "<img class='header' src='#{user.header}' alt='#{user.user_name}' />".html_safe
    else
      image_tag 'default_header.jpg', class: 'header', alt: user.user_name
    end
  end
end
