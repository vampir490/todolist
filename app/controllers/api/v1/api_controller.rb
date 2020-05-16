module Api
  module V1
    class ApiController < ActionController::Base
      before_action :authorize

      private

      def authorize
        @current_user = User.where(token: params[:token]).first if params[:token]

        render json: {error: 'unauthorized'}, status: :unauthorized unless @current_user
      end
    end
  end
end