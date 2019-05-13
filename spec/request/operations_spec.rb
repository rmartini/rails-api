require 'rails_helper'

RSpec.describe 'Operations API', type: :request do

  describe 'GET /v1/operations' do
    let!(:operations) { create_list(:operation, 3) }
    before { get '/v1/operations' }

    it "200 - Ok" do
      expect(response.status).to eq(200)
    end

    it 'returns operations subset' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

  end

  describe 'POST /v1/operations' do

    context 'when the request is valid' do
      let(:bank) { create(:bank) }
      let(:bank_period) { create(:bank_period, bank_id: bank.id) }
      let(:payload) { { amount: 5000, bank_period_id: bank_period.id } }
      before { post '/v1/operations', params: payload }

      it 'creates a operation' do
        expect(json['amount']).to eq(payload.dig(:amount))
        expect(json['bank_period_id']).to eq(payload.dig(:bank_period_id))
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:payload) { { bank_period_id: '2' } }
      before { post '/v1/operations', params: payload }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'calculated profit' do
      let(:bank) { create(:bank) }
      let(:bank_period) { create(:bank_period, bank_id: bank.id) }
      let(:payload) { { amount: 12000, bank_period_id: bank_period.id } }
      before { post '/v1/operations', params: payload }

      it 'correctly calculated profit' do
        expect(json['profit']).to eq(887.67)
      end

      it 'wrong calculated profit' do
        expect(json['profit']).not_to eq(905.25)
      end
    end

  end

end
