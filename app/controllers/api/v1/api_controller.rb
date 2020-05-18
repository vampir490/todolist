module Api
  module V1
    class ApiController < ApplicationController

      before_action :authorize_user

      private
      # The custom method to identify user
      # We search for the user by token if token presents in params
      def authorize_user
        @current_user = User.where(token: params[:token]).first if params[:token]

        render json: {error: 'unauthorized'}, status: :unauthorized unless @current_user
      end

      # Redefine method of the parent class to render JSON error
      def user_not_authorized
        render json: {error: 'Unauthorized user for this task'}, status: :unauthorized
      end
    end
  end
end