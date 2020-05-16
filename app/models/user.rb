class User < ApplicationRecord
  before_validation :generate_token, on: :create

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :entries

  private

  def generate_token
    self.token ||= SecureRandom.alphanumeric(30)
  end
end
