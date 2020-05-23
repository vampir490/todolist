require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  before do
    @params = {
      text: 'Test text',
      duedate: Time.parse("02/07/2800"),
      priority: 2,
      completed: true
    }

    # Creating user to use in tests
    @user = User.create(email: '1@r.ru',
                        password: '123456',
                        token: '123456')

    # Creating alternative user
    @another_user = User.create(email: '1@r.ru',
                                password: '123456',
                                token: '123456')
  end

  # User authorised
  context 'Authorized' do
    before do
      # Using Devise sign_in method
      sign_in @user
    end

    describe '#create' do
      # User can create new entry
      it 'creates entry' do
        post :create, params: {entry: @params}

        expect(Entry.where(@params).count).to eq 1
      end
    end

    describe '#index' do
      before do
        # Creating several entries with different priorities and due_dates
        @entries = (1..3).map do |i|
          Entry.create!(
            text: "Test task #{i}",
            priority: i,
            duedate: Time.parse("02/07/280#{i}"),
            user: @user
          )

          # Creating alternative entry of another user
          Entry.create!(
            text: "Test task another user",
            priority: 1,
            duedate: Time.parse("02/07/2804"),
            user: @another_user
          )
        end
      end

      # Test if it sorts with priority asc
      it 'sorts entries by default' do
        get :index
        expect(assigns(:entries).count).to eq 3
        expect(assigns(:entries).where(priority: 1, user: @user).first).to eq(@user.entries.first)
        expect(assigns(:entries).where(priority: 3, user: @user).first).to eq(@user.entries.last)
      end
    end
  end

  # User is not authorised
  context 'Unauthorized' do
    describe '#create' do
      # Unauthorized user cannot create new entry
      it 'does not let create entry' do
        # Send the request, but the entry is not created
        expect { post :create, params: {entry: @params} }.to change(Entry, :count).by(0)

        expect(response.status).not_to eq(200)
        expect(flash[:alert]).to be
      end
    end

    describe '#index' do
      it 'returns nil' do
        get :index
        expect(response.status).to eq(200)
        expect(assigns(:entries)).to be_nil
      end
    end
  end
end
