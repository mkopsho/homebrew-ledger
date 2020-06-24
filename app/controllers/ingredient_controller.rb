class IngredientsController < ApplicationController
  get '/ingredients' do
    if logged_in?
      ingredients = Ingredient.all
      grains = ingredients.select { |ingredient| ingredient.type_of == "grain" }
      @grain_list = grains.map { |grain| grain.name }
      hops = ingredients.select { |ingredient| ingredient.type_of == "hops" }
      @hop_list = hops.map { |hop| hop.name }
      yeast = ingredients.select { |ingredient| ingredient.type_of == "yeast" }
      @yeast_list = yeast.map { |yeast| yeast.name }
      erb :'ingredients/index'
    else
      redirect '/'
    end
  end

  get '/ingredients/:id' do
    if logged_in?
      @ingredient = Ingredient.find(params[:id])
      erb :'ingredients/show'
    else
      redirect '/'
    end
  end
end