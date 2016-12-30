include SessionsHelper

class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  	  redirect_to lessons_path
  	end
  end

  def about
  end
end
