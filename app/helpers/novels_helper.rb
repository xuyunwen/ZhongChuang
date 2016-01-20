module NovelsHelper

  def cover_tag(novel)
    if novel and novel.cover
      "<img class='cover' src='#{novel.cover}' alt='#{novel.name}' />".html_safe
    else
      image_tag 'default_cover.jpg', class: 'cover', alt: novel.name
    end
  end

  def little_cover_tag(novel)
    if novel and novel.cover
      "<img class='little_cover' src='#{novel.cover}' alt='#{novel.name}' />".html_safe
    else
      image_tag 'default_cover.jpg', class: 'little_cover', alt: novel.name
    end
  end


  def status_for_select_tag
    [
      [Novel::Status.names[0], Novel::Status::WORKING],
      [Novel::Status.names[1], Novel::Status::FINISHED],
    ]
  end
end
