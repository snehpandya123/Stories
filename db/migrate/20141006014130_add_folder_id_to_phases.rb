class AddFolderIdToPhases < ActiveRecord::Migration
  def change
    add_reference :phases, :folder, index: true
  end
end
