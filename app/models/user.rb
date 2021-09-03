class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :comments
  has_many :articles 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include PermissionConcern 
end
