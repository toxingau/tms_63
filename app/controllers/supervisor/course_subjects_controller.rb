class Supervisor::CourseSubjectsController < ApplicationController
  load_and_authorize_resource

  def show
    @course = @course_subject.course
    @subject = @course_subject.subject
  end
  
  def update
    if @course_subject.update_attributes course_subject_params
      if params[:course_subject][:status] == "start"
        load_activity current_user, "start_subject", @course_subject.subject.name
      else
        load_activity current_user, "finish_subject", @course_subject.subject.name
      end
      flash[:success] = t "course_subjects.start_success"
    else
      flash[:danger] = t "course_subjects.start_error"
    end
    redirect_to supervisor_course_path @course_subject.course
  end

  private
  def course_subject_params
    params.require(:course_subject).permit :status
  end
end
