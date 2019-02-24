module PostsHelper
  def status_label status
    span_tag_for_label status
  end

  private
    def span_tag_for_label status
      case status
      when "submitted"
        content_tag(:span, status.titleize, class: 'badge badge-primary')
      when "approved"
        content_tag(:span, status.titleize, class: 'badge badge-success')
      when "rejected"
        content_tag(:span, status.titleize, class: 'badge badge-danger')
      end
    end
end
