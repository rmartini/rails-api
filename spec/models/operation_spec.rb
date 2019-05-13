require 'rails_helper'

RSpec.describe Operation, type: :model do

  describe "ActiveModel validations" do
    it { should validate_presence_of(:bank_period) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end


  describe "ActiveRecord associations" do
    it { should belong_to(:bank_period) }
  end

  context "callbacks" do
    let(:bank) { create(:bank) }
    let(:bank_period) { create(:bank_period, bank_id: bank.id) }
    let(:operation) { create(:operation, amount: 5000, bank_period_id: bank_period.id) }

    describe "before_save" do

      it "calculate profit" do
        expect(operation.save).to eq(true)
        expect(operation.calculate_profit).not_to be_nil
      end
    end

  end

end
