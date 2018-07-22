module DeviseHelper
  def test_user
    @test_user ||= create(:user)
  end

  def auth_me_please
    request.headers.merge! test_user.create_new_auth_token
  end

  def auth_me_please_as(user)
    request.headers.merge! user.create_new_auth_token
  end

  def auth_me_please_as_creator(lesson)
    request.headers.merge! lesson.creator.create_new_auth_token
  end
end
