# frozen_string_literal: true

module ApplicationHelper
  def alert_class(alert_type)
    specific = case alert_type
               when 'notice' then 'alert alert-success'
               when 'alert' then 'alert alert-danger'
               else
                 'alert alert-primary'
               end
    "#{specific} alert-dismissible fade show"
  end
end
