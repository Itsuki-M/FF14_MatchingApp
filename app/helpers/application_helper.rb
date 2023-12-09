module ApplicationHelper
  def page_title(page_title = '', admin = false)
    base_title = if admin
      'FF14一緒に遊びませんか？(管理画面)'
      else
      'FF14一緒に遊びませんか？'
      end

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end
end
