class AddVideoToArticles < ActiveRecord::Migration[5.0]
  def change
  	add_column :articles, :link_video, :string
  end
end
