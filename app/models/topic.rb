class Topic < ApplicationRecord
  belongs_to :user
  validates :title, :user, presence: true

  has_many :posts, dependent: :destroy
end
