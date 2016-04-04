class SnippitsController < ApplicationController
  before_action :set_snippit, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /snippits
  # GET /snippits.json
  def index
    @snippits = current_user.snippits
  end

  # GET /snippits/1
  # GET /snippits/1.json
  def show
    if :html.empty?
      redirect_to edit_snippit_path(@snippit)
    end
  end

  # GET /snippits/new
  def new
    @snippit = Snippit.new
  end

  # GET /snippits/1/edit
  def edit
  end

  # POST /snippits
  # POST /snippits.json
  def create
    @snippit = Snippit.new(snippit_params)

    respond_to do |format|
      if @snippit.save
        format.html { redirect_to edit_snippit_path(@snippit), notice: 'Snippit was successfully created.' }
        format.json { render :show, status: :created, location: @snippit }
      else
        format.html { render :new }
        format.json { render json: @snippit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snippits/1
  # PATCH/PUT /snippits/1.json
  def update
    respond_to do |format|
      if @snippit.update(snippit_params)
        format.html { redirect_to edit_snippit_path(@snippit) }
        format.json { render :show, status: :ok, location: @snippit }
      else
        format.html { render :edit }
        format.json { render json: @snippit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snippits/1
  # DELETE /snippits/1.json
  def destroy
    @snippit.destroy
    respond_to do |format|
      format.html { redirect_to snippits_url, alert: 'Snippit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snippit
      @snippit = Snippit.find_by(id: params[:id], user_id:current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snippit_params
      params.require(:snippit).permit(:user_id, :html, :css, :title)
    end
end
