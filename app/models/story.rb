class Story < ActiveRecord::Base
	belongs_to :phase
	  has_reputation :votes, source: :user, aggregated_by: :sum
	attr_accessible :describtion ,:heading, :phase_id , :phase_attributes
	acts_as_votable
	validates :heading, :presence => true,
			  :length => { :within => 1..50 }
	validates :describtion, :presence => true
				
			  
end
