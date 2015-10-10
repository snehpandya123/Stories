class Folder < ActiveRecord::Base
	belongs_to :user 
	has_many :phases, dependent: :destroy

	

	validates :name, :presence => true,
			  :length => { :within => 1..50}
end
