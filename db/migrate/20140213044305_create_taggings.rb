class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_topic_id, :null => false
      t.integer :url_id, :null => false
    end
  end
end
