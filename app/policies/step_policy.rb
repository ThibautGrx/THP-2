class StepPolicy < ApplicationPolicy
  def update?
    record.lesson.creator == user
  end

  def destroy?
    record.lesson.creator == user
  end
end
