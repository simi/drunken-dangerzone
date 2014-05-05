#  {
#    "id": "01-04-2014",
#    "date": "01-04-2014",
#    "events": ["2"]
#  },

class Day
  attr_accessor :date_date

  include Virtus.model

  attribute :id, String
  attribute :date, String
  attribute :events, Array

  def initialize(id)
    super(id: id)
    setup_date
    setup_events
  end

  def setup_date
    self.date_date = Date.parse(self.id)
    self.date = sprintf("%02d-%02d-%d", self.date_date.day, self.date_date.month, self.date_date.year)
  end

  def setup_events
    self.events = []
  end
end
