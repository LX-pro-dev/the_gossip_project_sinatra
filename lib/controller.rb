require 'gossip'

class ApplicationController < Sinatra::Base
  # Affiche la homepage et tous les potins, passe les objets Gossip de tous les potins
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  # url qui permet de créer un ragot
  get '/gossips/new/' do
    erb :new_gossip
  end

  # permet de poster la saisie dans gossip.csv
  post '/gossips/new/' do
    # je créé un nouvel objet gossip et je save dans gossip en même temps
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'  # une fois sauvegardé, retour sur la homepage
  end

  # affiche un potin de manière unique via son id
  get '/gossips/:id' do
    erb :show, locals: {id: params['id'].to_i, gossips: Gossip.find(params['id'].to_i)}
  end

  # permet d'éditer avec le formualaire edit.erb
  get '/gossips/:id/edit' do
    erb :edit, locals: {id: params['id'].to_i, gossips: Gossip.find(params['id'].to_i)}
  end

  # récupère la saisie dans le formualaire pour update le potin
  post '/gossips/edit/' do
    Gossip.update(params['id'].to_i,params["gossip_author"], params["gossip_content"])
    redirect '/'
  end
end