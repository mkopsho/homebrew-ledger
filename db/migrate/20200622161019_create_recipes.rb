class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :description
      t.string :style
      t.belongs_to :user
      t.boolean :is_public?
    end
  end
end
