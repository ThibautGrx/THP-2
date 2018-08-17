class InvitationPolicy < ApplicationPolicy
  def create?
    record.classroom.creator == user
  end

  def update?
    record.student == user
  end

  def destroy?
    record.teacher == user || record.student == user
  end
end
