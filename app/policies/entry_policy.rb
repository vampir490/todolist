class EntryPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user_is_owner?(record)
  end

  def destroy?
    user_is_owner?(record)
  end

  class Scope < Scope
    def resolve
      scope.where(user: user) if user.present?
    end
  end

  private
  # We allow the action only if the user is present and it is the creator of entry
  def user_is_owner?(entry)
    user.present? && (entry.try(:user) == user)
  end
end
