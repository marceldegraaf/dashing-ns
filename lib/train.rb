class Train

  # This is an example class that interacts with the NS API.
  # In this case we've set the DEPART_FROM constant to "asd",
  # which is Amsterdam Central station.

  DEPART_FROM = 'asd'

  def initialize
    Ns.configure do |config|
      config.username = ENV['NS_API_USERNAME']
      config.password = ENV['NS_API_PASSWORD']
    end
  end

  def trip(destination, options = {})
    trip_options = { from: DEPART_FROM, to: destination, departure: Time.now + (20*60) }
    trip = Ns::Trip.new(trip_options.merge(options))
    travel_option = trip.travel_options.select { |to| to.optimal == true }.first

    {
      destination: destination,
      platform:    travel_option.platform,
      departure:   travel_option.planned_departure.strftime("%H:%M"),
      delay:       travel_option.delay / 60,
      delayed:     (travel_option.delay > 0 ? 'delayed' : 'not-delayed')
    }
  end

  def status
    disruptions? ? 'disruptions' : 'ok'
  end

  def status_text
    disruptions? ? 'disruptions at Amsterdam' : 'no disruptions at Amsterdam'
  end

  private

  def disruption_collection
    @disruption_collection ||= Ns::DisruptionCollection.new(station: DEPART_FROM, actual: true, include_planned: false)
  end

  def disruptions?
    disruption_collection.unplanned_disruptions.any?
  end

end
