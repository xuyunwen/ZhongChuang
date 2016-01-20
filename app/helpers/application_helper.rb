module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = t('page_title.main')
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end


  def to_html(str)
    out=''
    str.lines.each{|l| out<< "<p>#{CGI.escapeHTML(l.chop)}</p>"}
    out.html_safe
  end


end
