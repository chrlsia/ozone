class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    @url ='http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=89129&distance=0&API_KEY=6C05FE7C-2BEA-4C0C-864E-9A739030C0D6'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output=JSON.parse(@response)

    #Check for empty return result

    if @output.empty? || !@output
      @final_output = 'Error'
    else
      @final_output = @output[0]['AQI']
    end

     if @final_output == 'Error'
      @api_color ="silver"
     elsif @final_output.to_i <=50
      @api_color ='green'
      @api_description='AQI: Good (0 - 50)
Air quality is considered satisfactory, and air pollution poses little or no risk.'
     elsif @final_output.to_i>=51 && @final_output.to_i<=100
      @api_color="yellow"
      @api_description='AQI: Moderate (51 - 100)
Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution'
     elsif @final_output.to_i>=101 && @final_output.to_i<=150
      @api_color="orange"
      @api_description='AQI: Unhealthy for Sensitive Groups (101 - 150)
Although general public is not likely to be affected at this AQI range, people with lung disease, older adults and children are at a greater risk from exposure to ozone, whereas persons with heart and lung disease, older adults and children are at greater risk from the presence of particles in the air.'
     elsif @final_output.to_i>=151 && @final_output.to_i<=200
      @api_color ="red"
      @api_description='AQI: Unhealthy (151 - 200)
Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.'
     elsif @final_output.to_i>=201 && @final_output.to_i<=300
      @api_color="purle"
      @api_description='AQI: Very Unhealthy (201 - 300)
Health alert: everyone may experience more serious health effects.'
     elsif @final_output.to_i>=301 && @final_output.to_i<=500
      @api_color='maroon' 
      @api_description='AQI: Hazardous (301 - 500)
Health warnings of emergency conditions. The entire population is more likely to be affected.'
     end
  end
end
