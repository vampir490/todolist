module Api
  module V1
    class EntriesController < ApiController
      skip_before_action :verify_authenticity_token

      before_action :set_entry, only: [:update, :destroy]

      def index
        @entries = @current_user.entries

        render json: @entries.order(sort_column + " " + sort_direction) if @entries
      end

      def create
        @entry = @current_user.entries.build(entry_params)

        if @entry.save
          render json: @entry, status: :created, location: @entry
        else
          render json: @entry.errors, status: :unprocessable_entity
        end
      end

      def update
        #TODO update only your tasks via Pundit
        if @entry.update(entry_params)
          render json: @entry
        else
          render json: @entry.errors, status: :unprocessable_entity
        end
      end

      def destroy
        #TODO destroy only your tasks via Pundit
        @entry.destroy
      end

      private

      def entry_params
        params.require(:entry).permit(:text, :duedate, :priority, :completed, :token)
      end

      def set_entry
        @entry = Entry.find(params[:id])
      end

      def sort_column
        Entry.column_names.include?(params[:sort]) ? params[:sort] : "priority"
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
      end
    end
  end
end
