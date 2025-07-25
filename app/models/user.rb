require 'active_support/message_encryptor'

class User < ApplicationRecord
  has_many :websites, dependent: :destroy
  has_many :forms, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  # Additional user-related methods can be added here
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.encrypt_id(user_id)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secret_key_base[0..31])
    crypt.encrypt_and_sign(user_id.to_s)
  end

  def self.decrypt_id(token)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secret_key_base[0..31])
    User.find(crypt.decrypt_and_verify(token).to_i)
  rescue
    nil
  end
end
