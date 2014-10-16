class ChangeDescriptionFormateInStory < ActiveRecord::Migration
  def change

    change_column :stories, :describtion, :text
 
  end
end
