class EntriesController < ApplicationController
  before_action :set_entry, only: [:edit, :update, :destroy, :complete]

  before_action :set_entries, only: [:index]

  helper_method :sort_column, :sort_direction

  # GET /entries
  def index
  end

  # GET /entries/new
  def new
    @entry = current_user.entries.build
    authorize @entry
  end

  # GET /entries/1/edit
  def edit
    authorize @entry
  end

  # POST /entries
  def create
    @entry = current_user.entries.build(entry_params)

    authorize @entry

    if @entry.save
      redirect_to entries_url, notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /entries/1
  def update
    authorize @entry

    if @entry.update(entry_params)
      respond_to do |format|
        format.html do
          redirect_to entries_url, notice: 'Entry was successfully updated.'
        end

        format.js { render 'entries', entries: set_entries }
      end
    else
      redirect_to entries_url, alert: 'Entry was not updated.'
    end
  end

  # DELETE /entries/1
  def destroy
    authorize @entry

    @entry.destroy
    redirect_to entries_url, notice: 'Entry was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_entry
    @entry = Entry.find(params[:id])
  end

  def set_entries
    # it shows the table with tasks, ordered by column
    items_to_show = policy_scope(Entry)

    if items_to_show
      @entries = items_to_show.order(sort_column + " " + sort_direction)
    else
      @entries = nil
    end
  end

  # Only allow a trusted parameter "white list" through.
  def entry_params
    params.require(:entry).permit(:text, :duedate, :priority, :completed)
  end

  def sort_column
    Entry.column_names.include?(params[:sort]) ? params[:sort] : "priority"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
