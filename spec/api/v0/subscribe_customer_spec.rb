require 'rails_helper'

RSpec.describe 'Subscription API' do
  before :each do
    @customer1 = Customer.create!(first_name: 'Madi', last_name: 'Johnson', address: '123 Main St', email: 'madi@turing.edu')
    @customer2 = Customer.create!(first_name: 'Jordan', last_name: 'Whitten', address: '456 Main St', email: 'jordan@turing.edu')
    @tea1 = Tea.create!(title: 'Earl Grey', description: 'Tea, Earl Grey, Hot.', temperature: 200, brew_time: 5)
    @tea2 = Tea.create!(title: 'Green', description: 'Green Tea', temperature: 180, brew_time: 3)
    @tea3 = Tea.create!(title: 'Black', description: 'Black Tea', temperature: 190, brew_time: 4)
    @tea4 = Tea.create!(title: 'Oolong', description: 'Oolong Tea', temperature: 185, brew_time: 4)
    @headers = { 'CONTENT_TYPE' => 'application/json' }
  end

  describe 'happy path' do
    it 'can create a new subscription' do
      post "/api/v0/customers/#{@customer1[:id]}/subscriptions", params: {tea_id: @tea1[:id], title: 'Earl Grey', price: 10, frequency: 1}.to_json, headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq(201)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a(Hash)

      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to be_a(String)

      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to be_a(String)
      expect(json[:data][:type]).to eq('subscription')

      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to be_a(Hash)

      expect(json[:data][:attributes]).to have_key(:title)
      expect(json[:data][:attributes][:title]).to be_a(String)
      expect(json[:data][:attributes][:title]).to eq('Earl Grey')

      expect(json[:data][:attributes]).to have_key(:price)
      expect(json[:data][:attributes][:price]).to be_a(Float)
      expect(json[:data][:attributes][:price]).to eq(10.0)

      expect(json[:data][:attributes]).to have_key(:status)
      expect(json[:data][:attributes][:status]).to be_a(String)
      expect(json[:data][:attributes][:status]).to eq('active')

      expect(json[:data][:attributes]).to have_key(:frequency)
      expect(json[:data][:attributes][:frequency]).to be_a(String)
      expect(json[:data][:attributes][:frequency]).to eq('biweekly')

      expect(json[:data][:attributes]).to have_key(:customer_id)
      expect(json[:data][:attributes][:customer_id]).to be_a(Integer)
      expect(json[:data][:attributes][:customer_id]).to eq(@customer1[:id])

      expect(json[:data][:attributes]).to have_key(:tea_id)
      expect(json[:data][:attributes][:tea_id]).to be_a(Integer)
      expect(json[:data][:attributes][:tea_id]).to eq(@tea1[:id])

      expect(Subscription.last.title).to eq('Earl Grey')
    end
  end

  describe 'sad path' do
    it 'returns an error if customer does not exist' do
      post "/api/v0/customers/1000/subscriptions", params: {tea_id: @tea1[:id], title: 'Earl Grey', price: 10, frequency: 1}.to_json, headers: @headers

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json[:errors][:detail]).to eq('Validation failed: Customer must exist')
    end

    it 'returns an error if tea does not exist' do
      post "/api/v0/customers/#{@customer1[:id]}/subscriptions", params: {tea_id: 1000, title: 'Earl Grey', price: 10, frequency: 1}.to_json, headers: @headers

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json[:errors][:detail]).to eq('Validation failed: Tea must exist')
    end

    it 'returns an error if title is missing' do
      post "/api/v0/customers/#{@customer1[:id]}/subscriptions", params: {tea_id: @tea1[:id], title: '', price: 10, frequency: 1}.to_json, headers: @headers

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json[:errors][:detail]).to eq("Validation failed: Title can't be blank")
    end
  end
end