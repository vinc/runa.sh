class RunPolicy < ApplicationPolicy
  def create?
    user.enabled?
  end

  def update?
    user.enabled?
  end

  def destroy?
    user.enabled?
  end

  def cancel?
    user.enabled?
  end
end
