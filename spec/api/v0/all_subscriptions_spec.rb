require 'rails_helper'

RSpec.describe 'Subscription Index API' do
  before :each do
    @customer1 = Customer.create!(first_name: 'Madi', last_name: 'Johnson', address: '123 Main St', email: 'madi@turing.edu')
    @customer2 = Customer.create!(first_name: 'Jordan', last_name: 'Whitten', address: '456 Main St', email: 'jordan@turing.edu')
    @tea1 = Tea.create!(title: 'Earl Grey', description: 'Tea, Earl Grey, Hot.', temperature: 200, brew_time: 5)
    @tea2 = Tea.create!(title: 'Green', description: 'Green Tea', temperature: 180, brew_time: 3)
    @tea3 = Tea.create!(title: 'Black', description: 'Black Tea', temperature: 190, brew_time: 4)
    @tea4 = Tea.create!(title: 'Oolong', description: 'Oolong Tea', temperature: 185, brew_time: 4)
    @subscription1 = Subscription.create!(title: 'Earl Grey', price: 10, frequency: 1, customer_id: @customer1.id, tea_id: @tea1.id)
    @subscription2 = Subscription.create!(title: 'Green', price: 10, frequency: 0, customer_id: @customer1.id, tea_id: @tea2.id)
    @subscription3 = Subscription.create!(title: 'Black', price: 10, frequency: 1, customer_id: @customer1.id, tea_id: @tea3.id)
    @subscription4 = Subscription.create!(title: 'Oolong', price: 10, frequency: 0, customer_id: @customer2.id, tea_id: @tea4.id)
    @subscription5 = Subscription.create!(title: 'Earl Grey', price: 10, frequency: 1, customer_id: @customer2.id, tea_id: @tea1.id)
    @headers = { 'CONTENT_TYPE' => 'application/json' }
  end

  describe 'happy path' do
    it 'can get all subscriptions for a customer' do
      delete "/api/v0/customers/#{@customer1[:id]}/subscriptions/#{@subscription1[:id]}", headers: @headers
      get "/api/v0/customers/#{@customer1[:id]}/subscriptions", headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a(Array)

      expect(json[:data].count).to eq(3)
      expect(json[:data][2]).to be_a(Hash)

      expect(json[:data][2]).to have_key(:id)
      expect(json[:data][2][:id]).to be_a(String)
      expect(json[:data][2][:id]).to eq(@subscription1[:id].to_s)

      expect(json[:data][2]).to have_key(:type)
      expect(json[:data][2][:type]).to be_a(String)
      expect(json[:data][2][:type]).to eq('subscription')

      expect(json[:data][2]).to have_key(:attributes)
      expect(json[:data][2][:attributes]).to be_a(Hash)

      expect(json[:data][2][:attributes]).to have_key(:title)
      expect(json[:data][2][:attributes][:title]).to be_a(String)
      expect(json[:data][2][:attributes][:title]).to eq('Earl Grey')

      expect(json[:data][2][:attributes]).to have_key(:price)
      expect(json[:data][2][:attributes][:price]).to be_a(Float)
      expect(json[:data][2][:attributes][:price]).to eq(10.0)

      expect(json[:data][2][:attributes]).to have_key(:status)
      expect(json[:data][2][:attributes][:status]).to be_a(String)
      expect(json[:data][2][:attributes][:status]).to eq('cancelled')

      expect(json[:data][2][:attributes]).to have_key(:frequency)
      expect(json[:data][2][:attributes][:frequency]).to be_a(String)
      expect(json[:data][2][:attributes][:frequency]).to eq('biweekly')

      expect(json[:data][2][:attributes]).to have_key(:customer_id)
      expect(json[:data][2][:attributes][:customer_id]).to be_a(Integer)
      expect(json[:data][2][:attributes][:customer_id]).to eq(@customer1[:id])

      expect(json[:data][2][:attributes]).to have_key(:tea_id)
      expect(json[:data][2][:attributes][:tea_id]).to be_a(Integer)
      expect(json[:data][2][:attributes][:tea_id]).to eq(@tea1[:id])

      expect(json[:data][0]).to be_a(Hash)
      expect(json[:data][0][:attributes][:status]).to eq('active')
    end
  end

  describe 'sad path' do
    it 'returns 404 if customer does not exist' do
      get "/api/v0/customers/999999999/subscriptions", headers: @headers

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json[:errors][:detail]).to eq("Couldn't find Customer with 'id'=999999999")
    end
  end
end