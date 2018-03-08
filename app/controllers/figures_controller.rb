require 'pry'

class FiguresController < ApplicationController

  get '/' do
    redirect '/figures/new'
  end

  get '/figures' do
    erb :'figures/index'
  end

  get '/figures/new' do

    erb :'figures/new'
  end

  post '/figures/new' do

    #Creates new object
    @figure = Figure.create(name: params[:figure][:name])

    #Finds and adds selected titles
      if !!params[:figure][:title_ids]
        params[:figure][:title_ids].each {|title_id| @figure.titles << Title.find(title_id)}
      end

    #Adds newly created landmark (if applicable)
      unless params[:title][:name] == ""
        @figure.titles << Title.create(params[:title])
      end

    #Finds and adds selected landmarks
      if !!params[:figure][:landmark_ids]
        params[:figure][:landmark_ids].each {|landmark_id| @figure.landmarks << Landmark.find(landmark_id)}
      end

    #Adds newly created landmark (if applicable)
      unless params[:landmark][:name] == ""
        @figure.landmarks << Landmark.create(params[:landmark])
      end

    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])

    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :"figures/edit"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    #Finds and adds selected titles
      if !!params[:figure][:title_ids]
        params[:figure][:title_ids].each {|title_id| @figure.titles << Title.find(title_id) unless @figure.titles.include?(title_id)}
      end

    #Adds newly created landmark (if applicable)
      unless params[:title][:name] == ""
        @figure.titles << Title.create(params[:title])
      end

    #Finds and adds selected landmarks
      if !!params[:figure][:landmark_ids]
        params[:figure][:landmark_ids].each {|landmark_id| @figure.landmarks << Landmark.find(landmark_id) unless @figure.landmarks.include?(landmark_id)}
      end

    #Adds newly created landmark (if applicable)
      unless params[:landmark][:name] == ""
        @figure.landmarks << Landmark.create(params[:landmark])
      end
    @figure.save

    redirect "/figures/#{@figure.id}"
  end



end
