require 'sinatra'
require 'json'
require_relative 'hotp.rb'
require_relative 'timecounter.rb'

ANSWER = "spectrum"
SECRET = "secret_key"
INTERVAL = 30
GENERATOR = HOTP.new(SECRET, TimeBasedCounter.new(INTERVAL, Time))

get '/key' do
  "secret_key"
end

get '/otp' do
  GENERATOR.get + "\n"
end

post '/auth' do
  request.body.rewind
  payload = JSON.parse request.body.read

  puts payload

  if (payload['user'] == "admin" && payload['pass'] == "pass" && payload['otp'] == GENERATOR.get)
    return ANSWER
  else
    return "THOU SHALT NOT PASS!"
  end
end
