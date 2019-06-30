# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new
      require 'pry'; binding.pry;
      if user.admin?
        can :manage, :none
      else
        can :read, :none
      end
  end
end
