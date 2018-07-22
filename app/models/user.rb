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
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

<<<<<<< HEAD
  has_many :created_lessons,
           class_name: "Lesson",
           dependent: :destroy
=======
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_many :lessons, foreign_key: 'creator_id', inverse_of: 'creator', dependent: :destroy

  def as_json(opt = nil)
    super({ only: %i[id username email confirmed_at uid provider] }.merge(opt.to_h))
  end

  def confirmation_required?
    false
  end
>>>>>>> ca72ccb2324edbfa905051b10b2d420266879232
end
