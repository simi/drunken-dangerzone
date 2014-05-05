require 'spec_helper'

describe Event do
  let(:month) { Month.new(event.month_id) }
  let(:next_month) { Month.new('06-2014') }
  let(:previous_month) { Month.new('04-2014') }

  context "weekly" do
    let!(:event) { Event.create(month_id: '05-2014', day_id: '08-05-2014', weekly: 1, name: 'Ryba', place: 'U Rybáře') }
    it 'can found non-existing events for current month' do
      events = month.events
      expect(events.length).to eq(4)
    end

    it 'can found non-existing events for next month' do
      events = next_month.events
      expect(events.length).to eq(4)
    end

    it 'can found non-existing events for previous month' do
      events = previous_month.events
      expect(events.length).to eq(0)
    end
  end
end
