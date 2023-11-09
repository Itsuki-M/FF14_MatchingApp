module ApplicationHelper
  def page_title(page_title = '')
    base_title = "FF14一緒に遊びませんか？"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end

  end
end
