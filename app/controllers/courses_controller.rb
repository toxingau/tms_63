class CoursesController < ApplicationController
  load_and_authorize_resource only: :show

  def index
    @search = current_user.courses.ransack params[:q]
    @courses = @search.result.order(updated_at: :desc).page params[:page]
  end

  def show
    @user_course = @course.user_courses.find_by user_id: current_user.id
    @users_in_course = @course.user_courses.includes :user,
      user_subjects: [:subject, user_tasks: [:task]]
  end
end
