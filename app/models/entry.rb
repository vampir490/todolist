class Entry < ApplicationRecord

  validates :text, presence: true
  validates :duedate, inclusion: { in: Time.now.., message: " cannot be in past" }, on: [:create, :update]
  validates :priority, inclusion: { within: [1, 2 ,3] }
end
