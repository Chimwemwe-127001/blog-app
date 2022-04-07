class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is? :admin
      can :manage, :all
    else
      can :manage, Post, users_id: user.id
      can :manage, Comment, users_id: user.id
      can :read, :all
    end
  end
end
