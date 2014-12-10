json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :year, :release_date, :genre, :poster_url, :plot, :runtime, :oscars, :imdbid
  json.url movie_url(movie, format: :json)
end
