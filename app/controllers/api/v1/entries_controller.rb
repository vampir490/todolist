module Api
  module V1
    class EntriesController < ApiController
      def index
        @entries = @current_user.entries

        render json: @entries
      end

      private

      def entry_params
        params.require(:entry).permit(:text, :duedate, :priority, :completed, :token)
      end
    end
  end
end
