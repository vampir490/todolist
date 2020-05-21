require 'rails_helper'

RSpec.describe Api::V1::ApiController, type: :controller do
  before do
    expect(controller).to receive(:authorize_user).and_return(true)
  end

end