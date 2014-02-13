class ShortenedURL < ActiveRecord::Base
  validates :short_url, :presence => true, :uniqueness => true
  validates :long_url, :presence => true, :uniqueness => true
  validates :submitter_id, :presence => true

  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
  :visits,
  :class_name => "Visit",
  :foreign_key => :url_id,
  :primary_key => :id
  )

  has_many :visitors, :through => :visits, :source => :visitor

  def self.random_code
    while true
      new_short_url = SecureRandom.urlsafe_base64(16)
      short_urls = ShortenedURL.find_by({ :short_url => new_short_url })
      return new_short_url if short_urls.nil?
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    new_short_url = ShortenedURL.random_code
    ShortenedURL.create!(submitter_id: user.id, long_url: long_url, short_url: new_short_url)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniq
     self.visits.group(:user_id).distinct.count(:user_id).count
  end

  def num_recent_uniques
    self.visits.where(:created_at => (10.minutes.ago..Time.now)).group(:user_id).distinct.count(:user_id).count
  end


end