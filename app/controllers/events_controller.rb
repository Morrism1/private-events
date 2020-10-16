class EventsController < ApplicationController
  def index
    @events_upcoming = Event.upcoming
    @events_past = Event.past
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
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

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :date)
  end
end
