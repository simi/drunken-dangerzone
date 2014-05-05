require 'spec_helper'

describe Day do
  context 'setup' do
    let(:id) { "01-05-2014" }
    let(:day) { described_class.new(id) }
    it 'assings date' do
      expect(day.date).to eq('01-05-2014')
    end

    it 'assings events' do
      expect(day.events).to be_kind_of(Array)
    end
  end
end
