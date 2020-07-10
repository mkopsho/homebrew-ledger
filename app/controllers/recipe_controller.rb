class RecipesController < ApplicationController
  get '/recipes' do
    if logged_in?
      @public_recipes = Recipe.all.select { |recipe| recipe.is_public? }
      erb :'recipes/index'
    else
      redirect '/'
    end
  end

  get '/recipes/new' do
    if logged_in?
      ingredients = Ingredient.all
      grains = ingredients.select { |ingredient| ingredient.type_of == "grain" }
      hops = ingredients.select { |ingredient| ingredient.type_of == "hops" }
      yeast = ingredients.select { |ingredient| ingredient.type_of == "yeast" }
      
      grains = grains.map { |grain| grain.name }
      hops = hops.map { |hop| hop.name }
      yeast = yeast.map { |yeast| yeast.name }

      @grains = grains.uniq
      @hops = hops.uniq
      @yeast = yeast.uniq

      erb :'recipes/new'
    else
      redirect '/'
    end
  end

  post '/recipes' do
    if logged_in?
      @recipe = Recipe.create(name: params[:name], description: params[:description], style: params[:style], is_public?: params[:is_public?], user: current_user)
      amounts = params[:ingredients][:amount].reject { |amount| "0.00" } # Reject empties from our form. Can I catch this in the form itself?
      if params[:ingredients][:name]
        names = params[:ingredients][:name]
      end
      
      if params[:ingredients][:measure]
        measures = params[:ingredients][:measure]
      end
      
      if !amounts.empty?
        amounts = amounts.each_with_index.map { |element, index| element + measures[index].to_s } # Combine amounts and measurements arrays at same index.
      end

      if names
        count = 0
        while count < names.length do
          ingredient = Ingredient.create(name: names[count], quantity: amounts[count], recipe_id: @recipe.id)
          count += 1
        end
      end
      
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
      if @recipe && (@recipe.is_public? == true || @recipe.user == current_user)
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
      3.times do
        @recipe.ingredients.build # Returns new objects that are empty and not yet saved!
      end
      @ingredients = @recipe.ingredients

      if @recipe.user == current_user
        erb :'recipes/edit'
      else
        flash[:error] = "You do not have the correct permissions to do that."
        redirect '/recipes'
      end
    else
      redirect '/'
    end
  end

  patch '/recipes/:id' do
    if logged_in?
      recipe = Recipe.find_by(id: params[:id])
      
      if recipe.user == current_user
        recipe.update(name: params[:name], description: params[:description], style: params[:style], is_public?: params[:is_public?])
        recipe.ingredients.clear

        ingredient_names = params[:ingredient][:name].reject(&:empty?)
        ingredient_quantities = params[:ingredient][:quantity].reject(&:empty?)

        count = 0
        while count < ingredient_names.length do
          ingredient = Ingredient.create(name: ingredient_names[count], quantity: ingredient_quantities[count], recipe_id: recipe.id)
          count += 1
        end

      else
        redirect '/recipes'
      end

      if recipe.save
        redirect "/recipes/#{recipe.id}"
      else
        flash[:error] = "You do not have the correct permissions to do that."
        redirect '/recipes'
      end
    
    else
      redirect '/'
    end
  end

  delete '/recipes/:id' do
    if logged_in?
      recipe = Recipe.find_by(id: params[:id])
      if recipe.user == current_user
        recipe.destroy
        redirect '/recipes'
      else
        flash[:error] = "You do not have the correct permissions to do that."
        redirect '/recipes'
      end
    else
      redirect '/'
    end
  end
end