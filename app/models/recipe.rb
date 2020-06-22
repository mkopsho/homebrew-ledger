class Recipe < ActiveRecord::Base
  belongs_to :owner
  has_many :ingredients, through: :recipe_ingredients
end