class StepPolicy < ApplicationPolicy
  def create?
    record.lesson.creator == user
  end

  def update?
    record.lesson.creator == user
  end

  def destroy?
    record.lesson.creator == user
  end
end
