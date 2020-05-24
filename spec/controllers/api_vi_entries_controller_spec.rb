require 'rails_helper'

RSpec.describe Api::V1::EntriesController, type: :controller do
  before do
    @token = '123465'

    @user = User.create(email: 'api@r.ru',
                        password: '123456',
                        token: @token)

    @params = {
      text: 'Test text',
      duedate: Time.parse("02/07/2800"),
      priority: 2,
      completed: true
    }
  end

  context 'With token' do
    describe '#create' do
      it 'creates entry' do
        post :create, params: {token: @token, entry: @params}

        expect(Entry.where(@params).count).to eq 1
      end
    end

    describe '#update' do
      before do
        @entry = Entry.create!(
          text: "Entry before update",
          priority: 1,
          duedate: Time.parse("02/07/2802"),
          user: @user
        )
      end

      it 'updates entry' do
        put :update, params: {token: @token, id: @entry.id, entry: @params}
        @entry.reload

        expect(@entry.text).to eq 'Test text'
        expect(@entry.duedate).to eq '2800-07-01 21:00:00'
        expect(@entry.priority).to eq 2
        expect(@entry.completed).to eq true
      end

      it 'returns updated entry' do
        @params_api_updated = {
          text: 'Api text',
          duedate: Time.parse("02/07/2800"),
          priority: 3,
          completed: false
        }
        put :update, params: {token: @token, id: @entry.id, entry: @params_api_updated}

        json_response = JSON.parse(response.body)
        expect(json_response['text']).to eq @params_api_updated[:text]
      end
    end

    describe '#destroy' do
      before do
        @entry = Entry.create!(
          text: "Entry before destroy",
          priority: 1,
          duedate: Time.parse("02/07/2802"),
          user: @user
        )
        expect(@user.entries.count).to eq 1
      end

      it 'deletes entry' do
        delete :destroy, params: {token: @token, id: @entry.id}

        expect(@user.entries.count).to eq 0
      end
    end

    describe '#index' do
      it ''
    end
  end

  context 'No token' do
    before do
      @response_status = {"error" => "unauthorized"}
    end

    describe '#create' do
      it 'does not create entry without token' do
        post :create, params: {entry: @params}

        json_response = JSON.parse(response.body)
        expect(response.status).to eq(401)
        expect(json_response).to eq @response_status
      end
    end

    describe '#update' do
      before do
        @entry = Entry.create!(
          text: "Entry before update",
          priority: 1,
          duedate: Time.parse("02/07/2802"),
          user: @user
        )
      end

      it 'does not update entry without token' do
        put :update, params: {id: @entry.id, entry: @params_api_updated}

        json_response = JSON.parse(response.body)
        expect(response.status).to eq(401)
        expect(json_response).to eq @response_status
      end
    end

    describe '#destroy' do
      before do
        @entry = Entry.create!(
          text: "Entry before destroy",
          priority: 1,
          duedate: Time.parse("02/07/2802"),
          user: @user
        )
      end

      it 'does not destroy entry without token' do
        delete :destroy, params: {id: @entry.id}

        json_response = JSON.parse(response.body)
        expect(response.status).to eq(401)
        expect(json_response).to eq @response_status
      end
    end

    describe '#index' do
      it 'returns unauthorised error' do
        get :index
        json_response = JSON.parse(response.body)
        expect(response.status).to eq(401)
        expect(json_response).to eq @response_status
      end
    end
  end
end