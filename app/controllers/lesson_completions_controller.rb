class LessonCompletionsController < ApplicationController
include SessionsHelper
include LessonsHelper

  def create
  	lesson = Lesson.find(params[:lesson_id])
  	current_user.completed_lessons << lesson
  	if Lesson.all.all? {|lesson_to_check_for_completeness| completed_lesson?(lesson_to_check_for_completeness)}
      flash[:success] = "Great job! You have completed every lesson."
    else
  	  flash[:success] = "Great job! You have completed #{lesson.title}."
    end
  	redirect_to lessons_path
  end

end