class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new_recipe
  end

  post '/recipes' do
    recipe = Recipe.create(params)
    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = current_recipe
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = current_recipe
    erb :edit
  end

  patch '/recipes/:id' do
    current_recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{current_recipe.id}"
  end

  delete '/recipes/:id' do
    current_recipe.destroy
    redirect '/recipes'
  end

  helpers do
    def current_recipe
      Recipe.find_by(id: params[:id])
    end
  end

end
