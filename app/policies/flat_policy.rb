class FlatPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      #user.admin? ? scope.all : scope.where(user: user)
      scope.all
    end

    def index?
      # true
      user.blank?
    end

    def show?
      # true
    end

    def create?
      true
    end

    def new?
      true
    end

    def update?
      record.user == user || user.admin?
    end

    def destroy?
      record.user == user || user.admin?
    end

  end
end
