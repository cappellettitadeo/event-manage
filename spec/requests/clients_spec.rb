# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/clients', type: :request do
  let(:admin) { create :user, :admin }

  let(:valid_attributes) do
    name = Faker::Company.name
    { name: name, slug: name.parameterize }
  end

  let(:invalid_attributes) {
    { name: '', slug: '' }
  }

  before { sign_in admin }

  describe 'GET /index' do
    it_behaves_like 'authorization protected action' do
      subject(:send_request) { get clients_url }
    end

    it 'renders a successful response' do
      Client.create! valid_attributes
      get clients_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    let!(:client) { create :client }

    it_behaves_like 'authorization protected action' do
      subject(:send_request) { get client_url(client) }
    end

    it 'renders a successful response' do
      get client_url(client)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it_behaves_like 'authorization protected action' do
      subject(:send_request) { get new_client_url }
    end

    it 'renders a successful response' do
      get new_client_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    let(:client) { create :client }

    it_behaves_like 'authorization protected action' do
      subject(:send_request) { get edit_client_url(client) }
    end

    it 'render a successful response' do
      client = Client.create! valid_attributes
      get edit_client_url(client)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    it_behaves_like 'authorization protected action' do
      subject(:send_request) do
        post clients_url, params: { client: valid_attributes }
      end
    end

    context 'with valid parameters' do
      it 'creates a new Client' do
        expect {
          post clients_url, params: { client: valid_attributes }
        }.to change(Client, :count).by(1)
      end

      it 'redirects to the created client' do
        post clients_url, params: { client: valid_attributes }
        expect(response).to redirect_to(clients_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Client' do
        expect {
          post clients_url, params: { client: invalid_attributes }
        }.to change(Client, :count).by(0)
      end

      it 'redirects to events' do
        post clients_url, params: { client: invalid_attributes }
        expect(response).to redirect_to(clients_url)
      end
    end
  end

  describe 'PATCH /update' do
    let(:new_attributes) { { name: 'New name', slug: 'new-name' } }
    let!(:client) { create :client }

    it_behaves_like 'authorization protected action' do
      subject(:send_request) do
        patch client_url(client), params: { client: new_attributes }
      end
    end

    context 'with valid parameters' do
      it 'updates the requested client' do
        patch client_url(client), params: { client: new_attributes }
        client.reload
        expect({ name: client.name, slug: client.slug }).to eq new_attributes
      end

      it 'redirects to the client' do
        patch client_url(client), params: { client: new_attributes }
        client.reload
        expect(response).to redirect_to(edit_client_url(client))
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:client) { create :client }

    it_behaves_like 'authorization protected action' do
      subject(:send_request) { delete client_url(client) }
    end

    it 'destroys the requested client' do
      expect {
        delete client_url(client)
      }.to change(Client, :count).by(-1)
    end

    it 'redirects to the clients list' do
      delete client_url(client)
      expect(response).to redirect_to(clients_url)
    end
  end
end
