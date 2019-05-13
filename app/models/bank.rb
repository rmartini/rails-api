class Bank < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_many :bank_periods, dependent: :destroy

end
