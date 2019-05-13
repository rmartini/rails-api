require 'rails_helper'

RSpec.describe 'Bank Periods API', type: :request do

  let!(:bank) { create(:bank) }
  let!(:bank_periods) { create_list(:bank_period, 8, bank_id: bank.id) }
  let(:bank_id) { bank.id }
  let(:bank_period_id) { bank_periods.last.id }

  describe 'GET /v1/banks/:bank_id/bank_periods' do

    context 'when bank exists' do
      before { get "/v1/banks/#{bank_id}/bank_periods" }

      it "200 - Ok" do
        expect(response.status).to eq(200)
      end

      it 'returns bank periods subset' do
        expect(json).not_to be_empty
        expect(json.size).to eq(8)
      end
    end

    context 'when bank does not exist' do
      let(:bank_id) { 42 }
      before { get "/v1/banks/#{bank_id}/bank_periods" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

    end

  end

  describe 'GET /banks/:bank_id/bank_periods/:id' do
    before { get "/v1/banks/#{bank_id}/bank_periods/#{bank_period_id}" }

    context 'when bank period exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the bank periods' do
        expect(json['id']).to eq(bank_period_id)
      end
    end

    context 'when bank period does not exist' do
      let(:bank_period_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

    end
  end

  describe 'POST /v1/banks/:bank_id/bank_periods' do
    let(:payload) { { bank_id: bank.id, percentage: 20, days: 60, active: true } }

    context 'when request attributes are valid' do
      before { post "/v1/banks/#{bank_id}/bank_periods", params: payload }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/v1/banks/#{bank_id}/bank_periods", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /v1/banks/:bank_id/bank_periods/:id' do
    let(:payload) { { bank_id: bank.id, percentage: 25, days: 90, active: true } }

    before { put "/v1/banks/#{bank_id}/bank_periods/#{bank_period_id}", params: payload }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the bank period' do
        bank_period_obj = BankPeriod.find(bank_period_id)
        expect(bank_period_obj.percentage).to eq(25)
      end
    end

    context 'when the item does not exist' do
      let(:bank_period_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /v1/banks/:id/bank_periods/:id' do
    before { delete "/v1/banks/#{bank_id}/bank_periods/#{bank_period_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
