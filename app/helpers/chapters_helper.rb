module ChaptersHelper

  def chapter_status_for_select_tag
    [
        [Chapter::Status.names[0], Chapter::Status::ACTIVE],
        [Chapter::Status.names[1], Chapter::Status::LOCK],
        [Chapter::Status.names[2], Chapter::Status::TRASH],
    ]
  end

  def full_number(chapter)
    "第 #{chapter.number} 章 #{chapter.title}"
  end
end
