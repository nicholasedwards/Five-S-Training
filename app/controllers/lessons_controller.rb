class LessonsController < ApplicationController
include SessionsHelper

  def index
    @lessons = Lesson.all
    @current_user = current_user
  end

  def show
  	@lesson = Lesson.find(params[:id])
  end

end
