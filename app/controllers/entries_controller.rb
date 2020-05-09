class EntriesController < ApplicationController
  before_action :set_entry, only: [:edit, :update, :destroy]

  # GET /entries
  def index
    @entries = Entry.all
  end

  # GET /entries/new
  def new
    @entry = current_user.entries.build
    authorize @entry
  end

  # GET /entries/1/edit
  def edit
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
    if @entry.update(entry_params)
      redirect_to entries_url, notice: 'Entry was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /entries/1
  def destroy
    @entry.destroy
    redirect_to entries_url, notice: 'Entry was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
  def entry_params
    params.require(:entry).permit(:text, :duedate, :priority, :completed)
  end
end
