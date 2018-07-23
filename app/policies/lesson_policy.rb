class LessonPolicy
  attr_reader :user, :lesson

  def initialize(user, lesson)
    @user = user
    @lesson = lesson
  end

  def update?
    user == lesson.creator
  end

  def destroy?
    user == lesson.creator
  end
end
