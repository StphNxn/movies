class SiteController < ApplicationController
  def index
  end

  def index
   @q = params[:q].to_s
   @searching = false
   @movies = []
   if params[:s] == "search"
      @searching = true
       if params[:all]  == "all"
        @movies = Movie.order("RANDOM()")
      elsif @q != ""
        Movie.obtain @q
        @movies =  Movie.where("lower(title) like ? AND lower(genre) not like ? ", "%#{@q}%", "%short%")
      end
   end
  end

end
