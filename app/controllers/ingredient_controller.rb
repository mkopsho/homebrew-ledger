class IngredientsController < ApplicationController
  get '/ingredients' do
    ingredients = Ingredient.all
    grains = ingredients.select { |ingredient| ingredient.type_of == "grain" }
    @grain_list = grains.map { |grain| grain.name }
    hops = ingredients.select { |ingredient| ingredient.type_of == "hops" }
    @hop_list = hops.map { |hop| hop.name }
    yeast = ingredients.select { |ingredient| ingredient.type_of == "yeast" }
    @yeast_list = yeast.map { |yeast| yeast.name }
    erb :'ingredients/index'
  end

  get '/ingredients/:id' do
    @ingredient = Ingredient.find(params[:id])
    erb :'ingredients/show'
  end
end