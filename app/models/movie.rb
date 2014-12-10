class Movie < ActiveRecord::Base

	 def self.obtain q
    url = "http://imdbapi.com/?s=" + q
    @response = HTTParty.get(URI.encode(url))
    @result = JSON.parse(@response.body)
    if @result["Search"] == nil
      return {:error => "Sorry, that movie is not in the llamabase :'("}
    end
    @result["Search"].each do |result|
      if self.exists?(title: result["Title"]) and self.exists?(year: result["Year"])
        next
      end
      url = "http://imdbapi.com/?tomatoes=true&i=" + result["imdbID"]
      _r = HTTParty.get(URI.encode(url))
      _r = JSON.parse(_r.body)
      if(_r["Type"]!="movie")
        next
      end
      oscars = _r["Awards"].match(/won[\s+](?<wins>[\d]+)\s+(o|Oscar)/)
      oscars = ((oscars == nil || oscars["wins"] == nil) ? 0 : oscars["wins"])
      image =  "" #getImage(_r["Poster"])
      @movie = Movie.create({:title => _r["Title"],:year => _r["Year"],:release_date => _r["Released"],:genre => _r["Genre"],:poster_url => image, :plot => _r["Plot"],:runtime => _r["Runtime"] , :oscars => oscars, :imdbid => _r["imdbID"]})
    end
    return {:error => "" , :result => "Added new movies :) "}
  end

end
