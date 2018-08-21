class CreatePostsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |z|
      z.belongs_to :user
      z.string :title
      z.text :content
      z.string :creator
      z.string :image_url
      z.datetime :post_time
      z.boolean :public
      z.integer :user_id
    end
  end
end
