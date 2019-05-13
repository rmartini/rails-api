class Operation < ApplicationRecord

  attr_accessor :profit
  attr_accessor :percentage

  validates_presence_of :bank_period
  validates :amount, presence: true, numericality: { greater_than: 0 }

  belongs_to :bank_period

  before_save :calculate_profit, on: [:create, :update]

  def calculate_profit
    # total earning
    self.profit = ( self.amount * ( ( self.bank_period.percentage / 100 ) * self.bank_period.days / 365 ) ).round(2)
    # percentage difference
    self.percentage = ( ( ( ( self.amount + self.profit ) - self.amount ) / self.amount ) * 100 ).round(2)
  end

end
