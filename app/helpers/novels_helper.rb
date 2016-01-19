module NovelsHelper

  def cover_tag(novel)
    if novel and novel.cover
      "<img class='cover' src='#{novel.cover}'> alt='#{novel.name}'"
    else
      image_tag 'default_cover.jpg', class: 'cover', alt: novel.name
    end
  end

end
