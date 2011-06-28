class AddExerptAndLocationToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :exerpt, :string
    add_column :articles, :location, :string
  end

  def self.down
    remove_column :articles, :location
    remove_column :articles, :exerpt
  end
end
