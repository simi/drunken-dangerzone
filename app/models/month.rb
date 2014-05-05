#  {
#    "id": "05-2014",
#    "name": "Květen 2014",
#    "days": ["01-05-2014", "02-05-2014"],
#    "previousMonthId": "04-2014",
#    "previousMonthName": "Duben",
#    "nextMonthId": null,
#    "nextMonthName": null
#  },

class Month
  attr_accessor :date

  include Virtus.model

  attribute :id, String
  attribute :name, String
  attribute :days, Array
  attribute :events, Array
  attribute :previous_month_id, String
  attribute :previous_month_name, String
  attribute :next_month_id, String
  attribute :next_month_name, String

  def initialize(id)
    super(id: id)
    setup_month
    setup_days
    setup_name
    setup_previous_month
    setup_next_month
    setup_weekly_events
    self
  end

  def setup_month
    self.date = Date.strptime(self.id, '%m-%Y')
  end

  def setup_days
    days_count = Time.days_in_month(self.date.month, self.date.year)
    self.days = (1..days_count).to_a.collect { |d| sprintf("%02d-%02d-%d", d, self.date.month, self.date.year) }
  end

  def setup_name
    self.name = I18n.l(self.date, format: :month_year)
  end

  def setup_previous_month
    previous_month = self.date.last_month
    self.previous_month_name = I18n.l(previous_month, format: :month_year)
    self.previous_month_id = sprintf("%02d-%d", previous_month.month, previous_month.year)
  end

  def setup_next_month
    next_month = self.date.next_month
    self.next_month_name = I18n.l(next_month, format: :month_year)
    self.next_month_id = sprintf("%02d-%d", next_month.month, next_month.year)
  end

  def setup_weekly_events
    regular_events = Event.where('day_id <= ?', self.date.at_end_of_month)
    weekly_events = []
    regular_events.where(weekly: 1).each do |event|
      day_number = Date.parse(event.day_id).wday
      (self.days.select {|day| Date.parse(day).wday == day_number} - [event.day_id]).each_with_index do |day_id, index|
        weekly_events << Event.new(event.attributes.merge(weekly: nil, attending: 0, day_id: day_id, occurence: index, parent_id: event.id)) if Date.parse(event.day_id) < Date.parse(day_id)
      end
    end
    regular_events = regular_events.select {|e| Date.parse(e.day_id) <= self.date.at_end_of_month}
    regular_events = regular_events.select {|e| Date.parse(e.day_id) > self.date.at_beginning_of_month}
    self.events = (weekly_events + regular_events).sort_by(&:event_id_key)
  end
end
