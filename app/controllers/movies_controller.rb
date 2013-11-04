class MoviesController < ApplicationController

  helper_method :sort_column, :sort_direction, :where_ratings

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    session[:ratings] = where_ratings 
    session[:sort_column] = sort_column
    session[:sort_direction] = sort_direction
    @movies = Movie.order(session[:sort_column] + ' ' + session[:sort_direction])
    @movies = @movies.where(rating:  session[:ratings] )
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  private
    def sort_column
      Movie.column_names.include?(params[:sort]) ? params[:sort] : session[:sort_column].nil? || session[:sort_column].empty? ? "title" : session[:sort_column]
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction]  : "desc"
    end
    
    def where_ratings
      params[:ratings].nil? ? session[:ratings].nil? || session[:ratings].empty? ? Movie.all_ratings : session[:ratings] : params[:ratings].keys
    end
end
