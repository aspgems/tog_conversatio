class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string  :title
      t.text    :description
      t.integer :author_id, :references => :users, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :blogs
  end
end
