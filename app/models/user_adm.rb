class UserAdm < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, format: {with: /\A^[A-Za-z0-9._%+-]+@sistemadefrete\.com\.br$\z/, message: "deve possuir domain: @sistemadefrete.com.br" }
end
