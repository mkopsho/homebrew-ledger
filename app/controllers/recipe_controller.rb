class RecipesController < ApplicationController
  get '/recipes' do
    if logged_in?
      @public_recipes = Recipe.all.select { |recipe| recipe.is_public? }
      erb :'recipes/index'
    else
      erb :homepage
    end
  end

  get '/recipes/new' do
    @ingredients = Ingredient.all
    erb :'recipes/new'
  end

  post '/recipes' do
    # To do: instantiate an `Ingredient` object for each ingredient listed on the form and shovel into associated recipe method.
    @recipe = Recipe.create(name: params[:name], description: params[:description])
    ingredient = Ingredient.create(name: params[:ingredients][:name], quantity: params[:ingredients][:quantity])
    @recipe.ingredients << ingredient
    redirect to "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :'recipes/show'
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    @ingredients = Ingredient.all
    erb :'recipes/edit'
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.update(params)
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe = Recipe.destroy(params[:id])
    redirect '/recipes'
  end
end