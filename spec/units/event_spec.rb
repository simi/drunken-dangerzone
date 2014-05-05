require 'spec_helper'

describe Event do
  let(:event) { Event.create(month_id: '05-2014', day_id: '08-05-2014', weekly: 1, name: 'Ryba', place: 'U Rybáře') }
  let(:month) { Month.new(event.month_id) }
  it 'can found non-existing evets for month' do
    event
    events = month.events
    expect(events.length).to eq(4)
  end
end
