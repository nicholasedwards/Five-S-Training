class Lesson < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true
  has_many :lesson_completions
  has_many :users_who_completed_this_lesson, through: :lesson_completions, source: :user
end
