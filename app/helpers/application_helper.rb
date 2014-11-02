module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def admin_page?
    controller_name == 'students' || controller_name == 'review_seasons' || controller_name == 'student_payments'
  end

  def people_page?
    (current_page? :reviewers) || (current_page? :founders)
  end
end
