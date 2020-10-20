module EventsHelper
  def attend_button
    if logged_in?
      if @event.attendees.to_a.none?(current_user)
        render 'attend_form'
      else
        content_tag(:p, 'You are already attending this event')
      end
    else
      content_tag(:p, 'You must log in or sign up to view the attendees')
    end
  end
end
