require 'spec_helper'

describe Month do
  context 'setup' do
    let(:id) { "05-2014" }
    let(:month) { described_class.new(id) }

    it 'assigns name' do
      expect(month.name).to eq('Květen 2014')
    end

    it 'assigns days' do
      expect(month.days.length).to be(31)
    end

    it 'assings previous month' do
      expect(month.previous_month_name).to eq('Duben 2014')
    end

    it 'assings next month' do
      expect(month.next_month_name).to eq('Červen 2014')
    end

    it 'assigns next month id' do
      expect(month.next_month_id).to eq('06-2014')
    end

    it 'assigns previous month id' do
      expect(month.previous_month_id).to eq('04-2014')
    end
  end
end
