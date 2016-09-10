class StaticPagesController < ApplicationController
  def home
  	@lessons = Lesson.all
  end

  def about
  end
end
