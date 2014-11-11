class Story < ActiveRecord::Base
	belongs_to :phase
	has_many :comments
	  has_reputation :votes, source: :user, aggregated_by: :sum
	attr_accessible :describtion ,:heading, :phase_id , :phase_attributes
	acts_as_votable
	validates :heading, :presence => true,
			  :length => { :within => 1..50 }
	validates :describtion, :presence => true
				
searchable do
  text :heading, :boost => 5
  text :describtion, :publish_month
  text :comments do
    comments.map(&:content)
  end
  time :created_at
  string :publish_month
end

def publish_month
  created_at.strftime("%B %Y")
end
end
