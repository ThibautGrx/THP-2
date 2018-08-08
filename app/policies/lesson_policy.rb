class LessonPolicy < ApplicationPolicy
  def create_classroom?
    record.creator == user
  end

  def update?
    record.creator == user
  end

  def destroy?
    record.creator == user
  end
end
