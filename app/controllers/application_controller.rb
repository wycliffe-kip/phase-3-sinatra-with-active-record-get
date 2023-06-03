class ApplicationController < Sinatra::Base

  # Add Content-Type header for all responses 
  set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    games = Game.order(:title).limit(10)
    games.to_json
  end 

  # use the :id syntax to create a dynamic route 
  get '/games/:id' do 
    # look up the game in the database using its id 
    game = Game.find(params[:id])
    # send a JSON-formatted response of the game data 
    # game.to_json(include: { reviews: {include: :user}})


    # include associted reviews in the JSON response 
    game.to_json(only: [:id, :title, :genre, :price], include: { 
      reviews: {only: [:comment, :score], include: { 
        user: {only: [:name] }
       }}
    })
  end

end

