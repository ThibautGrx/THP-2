class LessonChannel < ApplicationCable::Channel
  def subscribed
    binding.pry
    reject unless params[:id]
    lesson = Lesson.find(params[:id])
    reject unless lesson
    stream_for lesson
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
