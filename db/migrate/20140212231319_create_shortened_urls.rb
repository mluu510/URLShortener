class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.integer :submitter_id, :null => false
      t.text    :short_url, :null => false
      t.text    :long_url, :null => false

      t.timestamps
    end

    add_index :shortened_urls, :long_url, :unique => true
  end
end
