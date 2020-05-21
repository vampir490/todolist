require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  before do
    @params = {
      text: 'Test text',
      duedate: Time.parse("02/07/2800"),
      priority: 2,
      completed: true
    }
  end

  context 'Authorized' do
    # User authorised
    before do
      user = User.create(email: '1@r.ru',
                         password: '123456',
                         token: '123456')
      # Using Devise sign_in method
      sign_in user
    end

    describe '#create' do
      # User can create new entry
      it 'creates entry' do
        post :create, params: {entry: @params}

        expect(Entry.where(@params).count).to eq 1
      end
    end
  end
end
