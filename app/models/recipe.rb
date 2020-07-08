class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :ingredients
  validates_presence_of :user_id

  def ingredients_attributes=(attributes)
    attributes.each do |attribute|
      unless attribute.any? {|key, value| value.blank?}
      quantity = attribute[:amount] + attribute[:measure]
      self.ingredients.build(name: attribute[:name], quantity: quantity)
      end
    end
  end
end