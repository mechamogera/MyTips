class Report < ActiveRecord::Base
  attr_accessible :body, :title
  validates :title, :presence => true
  belongs_to :user

  def accesable?(user)
    self.user == user
  end
end
