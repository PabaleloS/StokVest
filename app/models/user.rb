class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :owned_stokvels, class_name: 'Stokvel'
  has_many :members, dependent: :destroy
  has_many :stokvels, through: :members
  has_many :messages
  # has_one_attached :photo
end
