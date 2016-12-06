class LessonCompletionsController < ApplicationController
include SessionsHelper
include LessonsHelper

  def create
  	lesson = Lesson.find(params[:lesson_id])
  	current_user.completed_lessons << lesson
  	if all_lessons_completed?
      flash[:success] = "Great job! You have completed every lesson."
    else
  	  flash[:success] = "Great job! You have completed #{lesson.title}."
    end
  	redirect_to lessons_path
  end

end