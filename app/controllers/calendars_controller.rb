# frozen_string_literal: true

class CalendarsController < ApplicationController
  before_action :find_calendar_by_id, only: [:edit, :update]

  def index
    @calendars = Calendar.order(season_id: :DESC)
    @calendar = Calendar.new(season: Season.current)
  end

  def create
    @calendar = Calendar.new calendar_params
    @calendar.save!
    redirect_to section_calendars_path(current_section), notice: 'Calendrier créé'
  end

  def edit
    @new_day = Day.new calendar: @calendar, name: "J#{@calendar.days.count + 1}"
  end

  def update
    if @calendar.update(calendar_params)
      redirect_to edit_section_calendar_path(current_section, @calendar), notice: 'Calendrier mis à jour'
    else
      flash.now[:error] = 'Erreur lors de la mise à jour'
      render 'edit'
    end
  end

  protected

  def calendar_params
    if params[:calendar]
      params.require(:calendar).permit(:name, :season_id)
    else
      {}
    end
  end

  def find_calendar_by_id
    @calendar = Calendar.find params[:id]
  rescue ActiveRecord::RecordNotFound
    handle_404
  end
end
