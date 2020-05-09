class Entry < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :text, presence: true
  validates :duedate, inclusion: { in: Time.now.., message: " cannot be in past" }, on: [:create, :update],
            :allow_blank => true
  validates :priority, inclusion: { within: [1, 2 ,3] }

end
