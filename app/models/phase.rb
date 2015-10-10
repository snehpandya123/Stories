class Phase < ActiveRecord::Base
	belongs_to :folder 
	has_many :stories,dependent: :destroy

	validates :name, :presence => true,
			  :length => { :within => 1..50 }
end
