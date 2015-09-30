class MoviesController < ApplicationController
  
  def index

    keyword_query = "%#{params[:keyword]}%" if params[:keyword].present?
    duration_q = "#{params[:duration_query]}" if params[:duration_query].present?
  
    upper = nil
    lower = nil

    case duration_q
    when "1" then upper = 90; lower = 0
    when "2" then upper = 120; lower = 90
    when "3" then upper = 1000; lower = 120    
    else 
      duration_q = nil
    end

    if keyword_query.nil? && duration_q.nil?
      @movies = Movie.all 
    else
      @movies = Movie.title_match(keyword_query) unless keyword_query.nil?
      @movies = Movie.director_match(keyword_query) unless keyword_query.nil? || !((Movie.title_match(keyword_query)).empty?)
      @movies = Movie.duration_match(lower,upper) unless duration_q.nil?
    end 
    
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end


  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movies_path
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description
    )
  end

end
