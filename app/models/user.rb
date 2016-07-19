class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable,
    :rememberable, :validatable, :registerable

  has_many :activities, dependent: :destroy
  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks
  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :user_subjects, dependent: :destroy
  has_many :subjects, through: :user_subjects

  enum role: {trainee: 0, supervisor: 1, admin: 2}

  private
  def password_required?
    new_record? ? super: false
  end
end
