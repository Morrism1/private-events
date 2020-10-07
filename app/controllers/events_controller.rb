class EventsController < ApplicationController
  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build
    if @event.save
      flash[:sucess] = 'Event Successfully created...'
      redirect_to event_path(@event)
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end
end
