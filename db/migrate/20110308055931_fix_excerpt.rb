class FixExcerpt < ActiveRecord::Migration
  def self.up
		rename_column(Article, 'exerpt', 'excerpt')
  end

  def self.down
  end
end
