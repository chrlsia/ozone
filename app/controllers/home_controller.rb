class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    @url ='http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=89129&distance=0&API_KEY=6C05FE7C-2BEA-4C0C-864E-9A739030C0D6'
    @uri = URL(@url)
    @response = Net::HTTP.get(@uri)
    @output=JSON.parse(@response)

  end
end
