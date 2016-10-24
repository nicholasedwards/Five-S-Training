module LessonsHelper

  def completed_lesson?(lesson)
    lesson.users_who_completed_this_lesson.include? @current_user
  end

  def next_lesson?(i)
    i == @current_user.completed_lessons.count
  end

end
