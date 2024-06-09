class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # suppress :registerable so nobody can sign up
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :questions
  has_and_belongs_to_many :failed_questions, class_name: 'Question', join_table: 'missed_questions'

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :encrypted_password, presence: true

  enum role: { normal: 0, contributor: 1, admin: 2 }
end
