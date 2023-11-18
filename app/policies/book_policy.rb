# frozen_string_literal: true

class BookPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user.at_least_admin?
        @scope.all
      else
        @scope.where(author_id: @user.id)
      end
    end
  end

  def index?
    true
  end

  def show?
    user.at_least_admin? || record.author_id == user.id
  end

  def create?
    user.at_least_admin? || user.author?
  end

  def update?
    user.at_least_admin? || record.author_id == user.id
  end

  def destroy?
    user.at_least_admin? || record.author_id == user.id
  end

  def bulk_activation_toggle?
    user.at_least_admin?
  end
end
