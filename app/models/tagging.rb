class Tagging < ActiveRecord::Base
  belongs_to(
  :tag_topic,
  :class_name => "TagTopic",
  :foreign_key => :tag_topic_id,
  :primary_key => :id
  )

  belongs_to(
  :short_url,
  :class_name => "ShortenedURL",
  :foreign_key => :url_id,
  :primary_key => :id
  )
end