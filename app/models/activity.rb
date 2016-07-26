class Activity < ActiveRecord::Base
  belongs_to :user

  enum action_type: [:start_course, :finish_course, :start_subject, 
    :finish_subject, :add_trainee, :remove_user]

  def to_string
    case action_type
    when "start_course"
      "#{user.name} started course #{target_name}"
    when "finish_course"
      "#{user.name} finished course #{target_name}"
    when "start_subject"
      "#{user.name} started subject #{target_name}"
    when "finish_subject"
      "#{user.name} finished subject #{target_name}"
    when "add_trainee"
      "#{target_name} has added to course by #{user.name}"
    else
      "#{target_name} has removed by #{user.name}"
    end
  end
end
