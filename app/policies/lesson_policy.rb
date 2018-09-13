class LessonPolicy < ApplicationPolicy
  def create_classroom?
    record.creator == user
  end

  def create_step?
    record.creator == user
  end

  def update?
    record.creator == user
  end

  def destroy?
    record.creator == user
  end
end
