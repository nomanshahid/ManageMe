class RationalesController < ApplicationController
  before_action :set_rationale, only: [:show, :edit, :update, :destroy]

  # GET /rationales
  # GET /rationales.json
  def index
    @rationales = Rationale.all.order('created_at DESC')
  end

  # GET /rationales/1
  # GET /rationales/1.json
  def show
  end

  # GET /rationales/new
  def new
    @rationale = Rationale.new
  end

  # GET /rationales/1/edit
  def edit
  end

  # POST /rationales
  # POST /rationales.json
  def create
    @rationale = Rationale.new(rationale_params)
    @rationale.user = current_user
    respond_to do |format|
      if @rationale.save
        format.html { head :no_content }
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @rationale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rationales/1
  # PATCH/PUT /rationales/1.json
  def update
    respond_to do |format|
      if @rationale.update(rationale_params)
        format.html { redirect_to @rationale, notice: 'Rationale was successfully updated.' }
        format.json { render :show, status: :ok, location: @rationale }
      else
        format.html { render :edit }
        format.json { render json: @rationale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rationales/1
  # DELETE /rationales/1.json
  def destroy
    @rationale.destroy
    respond_to do |format|
      format.html { redirect_to rationales_url, notice: 'Rationale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rationale
      @rationale = Rationale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rationale_params
      params.fetch(:rationale, {})
      params.require(:rationale).permit!
    end
end
