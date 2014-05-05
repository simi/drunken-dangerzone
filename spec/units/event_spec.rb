require 'spec_helper'

describe Event do
  let(:month) { Month.new('05-2014') }
  let(:next_month) { Month.new('06-2014') }
  let(:previous_month) { Month.new('04-2014') }

  context "weekly and biweekly" do
    let!(:event_weekly) { Event.create(month_id: '05-2014', day_id: '08-05-2014', weekly: 1, name: 'Ryba', place: 'U Rybáře') }
    let!(:event_biweekly) { Event.create(month_id: '05-2014', day_id: '08-05-2014', biweekly: 1, name: 'Ryba', place: 'U Rybáře') }

    it 'can found non-existing events for current month' do
      events = month.events
      expect(events.length).to eq(6)
    end

    it 'can found non-existing events for next month' do
      events = next_month.events
      expect(events.length).to eq(6)
    end

    it 'can found non-existing events for previous month' do
      events = previous_month.events
      expect(events.length).to eq(0)
    end
  end

  context "weekly" do
    let!(:event) { Event.create(month_id: '05-2014', day_id: '08-05-2014', weekly: 1, name: 'Ryba', place: 'U Rybáře') }
    it 'can found non-existing events for current month' do
      events = month.weekly_events
      expect(events.length).to eq(3)
    end

    it 'can found non-existing events for next month' do
      events = next_month.weekly_events
      expect(events.length).to eq(4)
    end

    it 'can found non-existing events for previous month' do
      events = previous_month.weekly_events
      expect(events.length).to eq(0)
    end
  end

  context "biweekly" do
    let!(:event) { Event.create(month_id: '05-2014', day_id: '08-05-2014', biweekly: 1, name: 'Ryba', place: 'U Rybáře') }
    it 'can found non-existing events for current month' do
      events = month.biweekly_events
      expect(events.length).to eq(1)
    end

    it 'can found non-existing events for next month' do
      events = next_month.biweekly_events
      expect(events.length).to eq(2)
    end

    it 'can found non-existing events for previous month' do
      events = previous_month.biweekly_events
      expect(events.length).to eq(0)
    end
  end
end
