class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  validates :topic, :user, presence: true

  scope :by_topic, -> (topic_ids) { where(topic_id: topic_ids) }

  def as_json(options={})
    super(:include => :user)
  end
end
