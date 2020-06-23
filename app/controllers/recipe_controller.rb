class RecipesController < ApplicationController
  get '/recipes' do
    if logged_in?
      @user_recipes = Recipe.all.select { |recipe| recipe.user == current_user }
      @public_recipes = Recipe.all.select { |recipe| recipe.is_public? }
      erb :'recipes/index'
    else
      redirect '/'
    end
  end

  get '/recipes/new' do
    if logged_in?
      @ingredients = Ingredient.all
      erb :'recipes/new'
    else
      redirect '/'
    end
  end

  post '/recipes' do
    if logged_in?
      # To do: instantiate an `Ingredient` object for each ingredient listed on the form (also needs to be built correctly) and shovel into associated recipe method.
      @recipe = Recipe.create(name: params[:name], description: params[:description], is_public?: params[:is_public?], user: current_user)
      ingredient = Ingredient.create(name: params[:ingredients][:name], quantity: params[:ingredients][:quantity])
      @recipe.ingredients << ingredient
      if @recipe.save
        redirect "/recipes/#{@recipe.id}"
      else
        redirect "/recipes/new"
      end
    else
      redirect '/'
    end
  end

  get '/recipes/:id' do
    if logged_in?
      @recipe = Recipe.find_by(id: params[:id])
      if @recipe.is_public? == true || @recipe.user == current_user
        erb :'recipes/show'
      else
        redirect '/recipes'
      end
    else
      redirect '/'
    end
  end

  get '/recipes/:id/edit' do
    if logged_in?
      @recipe = Recipe.find_by(id: params[:id])
      @ingredients = Ingredient.all
      if @recipe.user == current_user
        erb :'recipes/edit'
      else
        # To do: create/expose flash message about not "owning" the recipe
        redirect '/recipes'
      end
    else
      redirect '/'
    end
  end

  patch '/recipes/:id' do
    if logged_in?
      @recipe = Recipe.find_by(id: params[:id])
      @recipe.update(params)
      if @recipe.user == current_user
        redirect "/recipes/#{@recipe.id}"
      else
        # To do: create/expose flash message about not "owning" the recipe
        redirect '/recipes'
      end
    else
      redirect '/'
    end
  end

  delete '/recipes/:id' do
    if logged_in?
      @recipe = Recipe.find_by(id: params[:id])
      if @recipe.user == current_user
        @recipe.destroy
        redirect '/recipes'
      else
        # To do: create/expose flash message about not "owning" the recipe
        redirect '/recipes'
      end
    else
      redirect '/'
    end
  end
end