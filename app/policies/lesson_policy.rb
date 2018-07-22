class LessonPolicy
  attr_reader :user, :lesson

  def initialize(user, lesson)
    @user = user
    @lesson = lesson
  end

  def show?
    user
  end

  def create?
    user
  end

  def update?
    user == lesson.creator
  end

  def destroy?
    user == lesson.creator
  end
end
