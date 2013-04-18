require 'ns' # <= make sure the "ns-api" gem is in your Gemfile

@train = Train.new

SCHEDULER.every('5m', allow_overlapping: false, first_in: '1s') do
  trips = [
    @train.trip('Utrecht Centraal')
  ]

  trips = trips.sort { |a,b| a[:departure] <=> b[:departure] }

  disruptions = @train.status_text
  status = @train.status

  send_event("ns", { items: trips, disruptions: disruptions, status: status })
end
