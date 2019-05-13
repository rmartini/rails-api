require 'rails_helper'

RSpec.describe 'Bank API', type: :request do

  let!(:banks) { create_list(:bank, 5) }
  let(:bank_id) { banks.last.id }

  describe 'GET /v1/banks' do
    before { get '/v1/banks' }

    it "200 - Ok" do
      expect(response.status).to eq(200)
    end

    it 'returns banks subset' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

  end

  describe 'GET /v1/banks/:id' do

    context 'when the record exists' do
      before { get "/v1/banks/#{bank_id}" }

      it 'returns the bank' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(bank_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:bank_id) { 42 }
      before { get "/v1/banks/#{bank_id}" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

  end

  describe 'POST /v1/banks' do

    context 'when the request is valid' do
      let(:payload) { { name: 'Banco Ciudad' } }
      before { post '/v1/banks', params: payload }

      it 'creates a bank' do
        expect(json['name']).to eq(payload.dig(:name))
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:payload) { { title: 'Banco Ciudad' } }
      before { post '/v1/banks', params: payload }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /v1/banks/:id' do
    let(:payload) { { id: bank_id, name: 'Banco Galicia' } }

    context 'when the record exists' do
      before { put "/v1/banks/#{payload.dig(:id)}", params: payload }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /v1/banks/:id' do
    before { delete "/v1/banks/#{bank_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
