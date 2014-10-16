class Folder < ActiveRecord::Base
	belongs_to :user 
	has_many :phases, dependent: :destroy

	attr_accessible :name , :user_id

	validates :name, :presence => true,
			  :length => { :within => 1..10 }
end
