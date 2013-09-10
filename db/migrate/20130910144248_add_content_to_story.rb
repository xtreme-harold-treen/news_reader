class AddContentToStory < ActiveRecord::Migration
  def change
    add_column :stories, :title, :string
    add_column :stories, :description, :string
    add_column :stories, :date, :string
  end
end
