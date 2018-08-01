class InvitationPolicy < ApplicationPolicy
  def create?
    record.classroom.creator == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user || record.classroom.creator == user
  end
end
