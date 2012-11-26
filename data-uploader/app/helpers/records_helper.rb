module RecordsHelper

  def record_status(record)
    status_class = case record.status
      when "pending"
        "warning"
      when "failed"
        "important"
      when "processed"
        "success"
      end
    content_tag :span, record.status, class: "label label-#{status_class}"
  end

  def record_row_class(record)
    case record.status
    when "pending"
      "warning"
    when "failed"
      "error"
    when "processed"
      "success"
    end
  end

end