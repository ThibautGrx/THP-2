class LessonsController < ApplicationController
  def show
    lesson = Lesson.find(params[:id])
    render json: lesson
  end

  def index
    lessons = Lesson.all
    render json: lessons
  end

  def create
    lesson = Lesson.create(create_params)
    if lesson.errors.empty?
      render json: lesson
    else
      render json: { errors: lesson.errors }
    end
  end

  def update
    lesson = Lesson.find(params[:id])
    lesson.update(update_params)
    if lesson.errors.empty?
      render json: lesson
    else
      render json: { errors: lesson.errors }
    end
  end

  def destroy
    lesson = Lesson.find(params[:id])
    lesson.destroy
    render body: nil, status: :no_content
  end

  private

  def create_params
    params.permit(:title, :description)
  end

  def update_params
    params.permit(:title, :description)
  end
end
