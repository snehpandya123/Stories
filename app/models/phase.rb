class Phase < ActiveRecord::Base
	belongs_to :folder 
	has_many :stories,dependent: :destroy

	attr_accessible :name , :folder_id , :folder_attributes

	validates :name, :presence => true,
			  :length => { :within => 1..10 }
end
