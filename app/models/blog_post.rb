class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  
  scope :draft, -> { where(published_at: nil) } # BlogPost.draft
  scope :published, -> {where("published_at <= ?", Time.current)}
  scope :scheduled, -> {where("published_at > ?", Time.current)}
  scope :sorted, -> { order( published_at: :desc , updated_at: :desc) }
  
  def draft?
    published_at.nil?
  end
  
  def published?
    published_at? && published_at <= Time.current
  end
  
  def scheduled?
    published_at? && published_at > Time.current
  end
end
