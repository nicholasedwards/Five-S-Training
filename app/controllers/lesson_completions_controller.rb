class LessonCompletionsController < ApplicationController
include SessionsHelper

  def create
  	lesson = Lesson.find(params[:lesson_id])
  	current_user.completed_lessons << lesson
  	flash[:success] = "Great job! You have completed #{lesson.title}."
  	redirect_to lessons_path
  end

end