class ClassroomPolicy
  attr_reader :user, :classroom

  def initialize(user, classroom)
    @user = user
    @classroom = classroom
  end

  def update?
    user == classroom.teacher
  end

  def destroy?
    user == classroom.teacher
  end
end
