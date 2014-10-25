class Comment < ActiveRecord::Base
	belongs_to :story
	attr_accessible :body , :story_id

	validates :body, :presence => true,:length => { :within => 1..50}
end
