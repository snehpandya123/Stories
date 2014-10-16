class AddHeadingToStory < ActiveRecord::Migration
  def change
    add_column :stories, :heading, :string
  end
end
