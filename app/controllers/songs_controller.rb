class SongsController < ApplicationController
    get '/songs' do
      @songs = Song.all
      erb :'/songs/index'
    end
  
    get '/songs/new' do
      erb :'/songs/new'
    end
  
    get '/songs/:slug' do
      @song = Song.find_by_slug(params[:slug])
      erb :'/songs/show'
    end
  
    post '/songs' do
      @song = Song.new(name:params[:song_name])
      @artist = Artist.find_or_create_by(name:params[:artist_name])
      @genres = params[:genres].map {|genre_data| Genre.find(genre_data)}
      @song.artist = @artist
      @song.genres = @genres
      @song.save
      flash[:notice] = "Successfully created song."
      redirect to "/songs/#{@song.slug}"
    end
  
    get '/songs/:slug/edit' do
      @song = Song.find_by_slug(params[:slug])
      erb :'/songs/edit'
    end
  
    patch '/songs/:slug' do
      @song = Song.find_by_slug(params[:slug])
      @artist = Artist.find_or_create_by(name:params[:artist_name])
      @genres = params[:genres].map {|genre_data| Genre.find(genre_data)}
      @song.artist = @artist
      @song.genres = @genres
      if @song.save
      flash[:message] = "Successfully updated song."
      redirect to "/songs/#{song_name}"
      else 
      erb :'/songs/show'
      end 
    end
end