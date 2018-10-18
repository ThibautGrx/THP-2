class ClassroomChannel < ApplicationCable::Channel
  def subscribed
    reject unless params[:id]
    classroom = Classroom.find(params[:id])
    reject unless classroom
    stream_for classroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
