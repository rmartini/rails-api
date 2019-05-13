require 'rails_helper'

RSpec.describe Bank, type: :model do

  describe "ActiveModel validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "ActiveRecord associations" do
    it { should have_many(:bank_periods).dependent(:destroy) }
  end
end
