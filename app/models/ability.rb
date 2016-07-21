class Ability
  include CanCan::Ability

  def initialize user, namespace
    user ||= User.new
    if user.admin?
      can :manage, [User, Subject, Course]
      can [:add, :destroy], UserCourse
      if namespace == "supervisor"
        cannot :manage, :all
      end
    elsif user.supervisor?
      can [:add, :destroy], UserCourse
      can :read, Course
      if namespace == "admin"
        cannot :manage, :all
      end
    else
      can :read, [User, Course]
      can :read, UserCourse, user_id: user.id
      if namespace == "supervisor" || namespace == "admin"
        cannot :manage, :all
      end
    end
  end
end
