class IngredientsController < ApplicationController
  get '/ingredients' do
    @ingredients = Ingredient.all
    erb :'ingredients/index'
  end

  get '/ingredients/:id' do
    @ingredient = Ingredient.find(params[:id])
    erb :'ingredients/show'
  end
end