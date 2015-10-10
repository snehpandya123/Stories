class Story < ActiveRecord::Base
	belongs_to :phase
	has_many :comments
	has_reputation :votes, source: :user, aggregated_by: :sum
	
	acts_as_votable
	validates :heading, :presence => true,
			  :length => { :within => 1..50 }
	validates :describtion, :presence => true
				

def self.search(search)
  where("LOWER(heading) LIKE ?", "%#{search.downcase}%") 
end
def publish_month
  created_at.strftime("%B %Y")
end
end
