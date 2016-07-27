class Admin::SubjectsController < ApplicationController
  load_and_authorize_resource

  def index
    @search = @subjects.ransack params[:q]
    @subjects = @search.result.order(updated_at: :desc).page params[:page]
  end

  def new
    Settings.default_number_of_tasks.times {@subject.tasks.build}
  end

  def create
    if @subject.save
      flash[:success] = t "subjects.created"
      redirect_to admin_subjects_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "subjects.edit_success"
      redirect_to admin_subjects_path
    else
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t "subjects.subject_deleted"
    else
      flash[:danger] = t "subjects.subject_empty"
    end
    redirect_to admin_subjects_path
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description,
      tasks_attributes: [:id, :name, :description, :_destroy]
  end
end
