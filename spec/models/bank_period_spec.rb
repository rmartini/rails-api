require 'rails_helper'

RSpec.describe BankPeriod, type: :model do

  describe "ActiveModel validations" do
    it { should validate_presence_of(:bank) }
    it { should validate_presence_of(:percentage) }
    it { should validate_presence_of(:days) }
    it { should validate_presence_of(:active) }
    it { should validate_numericality_of(:percentage) }
    it { should validate_numericality_of(:days).only_integer }
    it { should validate_inclusion_of(:days).in_array(BankPeriod::DAYS) }
  end

  describe "ActiveRecord associations" do
    it { should belong_to(:bank) }
    it { should have_many(:operations).dependent(:destroy) }
  end


end
