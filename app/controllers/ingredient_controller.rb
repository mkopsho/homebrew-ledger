class IngredientsController < ApplicationController
  get '/ingredients' do
    @ingredients = Ingredient.all
    erb :'ingredients/index'
  end

  get '/ingredients/new' do
    erb :'ingredients/new'
  end

  post '/ingredients' do
    @ingredient = Ingredient.create(params)
    redirect to "/ingredients/#{@ingredient.id}"
  end

  get '/ingredients/:id' do
    @ingredient = Ingredient.find(params[:id])
    erb :'ingredients/show'
  end

  get '/ingredients/:id/edit' do
    @ingredient = Ingredient.find(params[:id])
    erb :'ingredients/edit'
  end

  patch '/ingredients/:id' do
    @ingredient = Ingredient.find(params[:id])
    @ingredient.update(params)
    redirect "/ingredients/#{@ingredient.id}"
  end

  delete '/ingredients/:id' do
    @ingredient = Ingredient.destroy(params[:id])
    redirect '/ingredients'
  end
end