require 'uri'
require 'net/http'
require 'openssl'

class PagesController < ApplicationController
  def home
    url = URI("https://v3.football.api-sports.io/standings?league=94&season=2022")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'v3.football.api-sports.io'
    request["x-rapidapi-key"] = ENV["FOOTBALL_API_KEY"]

    response = http.request(request)
    @response = JSON.parse(response.body)
    @league_name = @response["response"].first["league"]["name"]
    @country = @response["response"].first["league"]["country"]
    @season = @response["response"].first["league"]["season"]
    @league_logo_url = @response["response"].first["league"]["logo"]
    @standings = JSON.parse(response.body)["response"].first["league"]["standings"].first
    @points = JSON.parse(response.body)["response"].first["league"]["standings"].first
  end
end
