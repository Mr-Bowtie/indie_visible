class BookPolicy < ApplicationPolicy
  def show?
    user.admin? || record.user == user
  end

  def create?
    user.admin? || user.author?
  end

  def update?
    user.admin? || record.user == user
  end

  def destroy?
    user.admin? || record.user == user
  end
end

