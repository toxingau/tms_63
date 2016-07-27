class Supervisor::CoursesController < ApplicationController
  load_and_authorize_resource

  def index
    @search = current_user.courses.ransack params[:q]
    @courses = @search.result.order(updated_at: :desc).page params[:page]
  end

  def show
    @users_in_course = @course.user_courses.includes :user
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "supervisor.update_success"
      redirect_to supervisor_course_path @course
    else
      flash[:danger] = t "supervisor.update_fail"
      redirect_to supervisor_course_path
    end
  end

  private
  def course_params
    params.require(:course).permit :status
  end
end
