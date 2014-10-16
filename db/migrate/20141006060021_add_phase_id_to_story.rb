class AddPhaseIdToStory < ActiveRecord::Migration
  def change
    add_reference :stories, :phase, index: true
  end
end
