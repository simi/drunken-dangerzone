# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  month_id   :string(255)
#  day_id     :string(255)
#  name       :string(255)
#  date       :datetime
#  place      :string(255)
#  attending  :integer          default(0), not null
#  weekly     :integer
#  biweekly   :integer
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Event < ActiveRecord::Base
  attr_accessor :occurence
  has_one :parent_event, class_name: 'Event', foreign_key: :parent_id

  after_initialize :prepare_occurence

  def event_id_key
    sprintf("%d-%s-%s", parent_id || id, month_id, occurence)
  end

  def prepare_occurence
    self.occurence = 0 unless self.occurence
  end
end
