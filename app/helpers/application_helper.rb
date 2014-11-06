module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def admin_page?
    controller.is_a? AdminController
  end

  def people_page?
    (current_page? :reviewers) || (current_page? :founders)
  end
end
