require 'csv'
require 'erb'


data = CSV.foreach("planet_express_logs.csv", headers: true, :header_converters => :symbol)

class Delivery

attr_accessor :destination, :shipment, :crates, :money

def initialize(destination:, shipment:, crates:, money:)
  @destination = destination
  @shipment = shipment
  @crates = crates
  @money = money.to_i
end
# end of Initialize method

def pilot
  if destination == " Earth"
    pilot = "Fry"
  elsif destination == " Mars"
    pilot = "Amy"
  elsif destination == " Uranus"
    pilot = "Bender"
  else
    pilot = "Leela"
  end
end
# Pilot Method ends here

def amy?
  pilot == "Amy"
end

def fry?
  pilot == "Fry"
end

def bender?
  pilot == "Bender"
end

def leela?
  pilot == "Leela"
end

end
# Delivery Class ends here

new_delivery = []
data.each do |row|
  new_delivery << Delivery.new(row)
end


group_by_pilot = new_delivery.group_by {|job| job.pilot}
#This is a hash

# hash.each do |key, value|
#   puts key
#   puts value
# end




total = new_delivery.reduce(0) {|sum, trip| sum + trip.money}
puts total
# puts group money total

new_delivery.each { |job| puts job.pilot }
puts data.inspect


  new_file = File.open("./report.html" , "w+")
  new_file << ERB.new(File.read("report.erb")).result(binding)
  new_file.close
