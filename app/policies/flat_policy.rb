class FlatPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end

    def index?
      false
    end

    def show?
      true
    end

    def create?
      true
    end

    def new?
      true
    end

    def update?
      record.user == user
    end

    def destroy?
      record.user == user
    end

  end
end
