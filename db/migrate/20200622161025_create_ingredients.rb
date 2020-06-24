class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :type_of
      t.string :quantity
      t.belongs_to :recipe
    end
  end
end
