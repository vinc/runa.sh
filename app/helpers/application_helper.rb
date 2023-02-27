module ApplicationHelper
  def duration_to_human(duration)
    parts = []
    if duration > 86400
      parts << "#{(duration / 86400).to_i}h"
      duration %= 86400
    end
    if duration > 3600
      parts << "#{(duration / 3600).to_i}h"
      duration %= 3600
    end
    if duration > 60
      parts << "#{(duration / 60).to_i}m"
      duration %= 60
    end
    if duration > 0
      parts << "#{duration.to_i}s"
    end
    parts[0..1].join(" ")
  end

  def form_errors_heading(resource)
    I18n.t(
      "errors.messages.not_saved",
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase
    )
  end
end
