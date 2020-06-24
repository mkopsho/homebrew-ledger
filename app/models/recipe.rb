class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :ingredients
  validates_presence_of :user_id
end