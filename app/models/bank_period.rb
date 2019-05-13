class BankPeriod < ApplicationRecord

  DAYS = [30, 60, 90, 120, 150, 180, 270, 365]

  validates :bank, :active, presence: true
  validates :percentage, presence: true, numericality: { greater_than: 0 }
  validates :days, presence: true, numericality: { only_integer: true }, inclusion: DAYS

  belongs_to :bank
  has_many :operations, dependent: :destroy
end
