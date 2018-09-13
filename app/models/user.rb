# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  username               :string
#  email                  :string
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  token                  :string           default([]), is an Array
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_many :lessons, foreign_key: 'creator_id', inverse_of: 'creator', dependent: :destroy
  has_many :created_classrooms, class_name: 'Classroom', foreign_key: 'creator_id', inverse_of: 'creator', dependent: :destroy

  has_many(:sent_invitations, class_name: 'Invitation', inverse_of: 'teacher', dependent: :destroy, foreign_key: 'teacher_id')
  has_many(:received_invitations, class_name: 'Invitation', inverse_of: 'student', dependent: :destroy, foreign_key: 'student_id',)
  has_many(:joined_classrooms, -> { where(invitations: { accepted: true }) }, through: :received_invitations, inverse_of: :students, source: :lesson)

  has_many :votes, dependent: :destroy
  has_many :upvoted_questions, through: :votes, source: :question
  has_many :ticked_steps, dependent: :destroy
  has_many :understood_steps, through: :ticked_steps, source: :step

  #  def understood_step(classroom)
  #    step_ids = ticked_steps.select{ |item| item.classroom == classroom }.map(&:user_id)
  #    Step.where(id: step_ids)
  #  end

  def as_json(opt = nil)
    super({ only: %i[id username email confirmed_at uid provider] }.merge(opt.to_h))
  end

  def confirmation_required?
    false
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def generate_token
    token << SecureRandom.hex(20)
    save
    TokenCleanupJob.set(wait: 5.minutes).perform_later(self)
  end
end
