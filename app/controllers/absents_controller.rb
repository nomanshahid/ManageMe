class AbsentsController < ApplicationController
  before_action :set_absent, only: [:show, :edit, :update, :destroy]

  # GET /absents
  # GET /absents.json
  def index
    @absents = Absent.all
  end

  # GET /absents/1
  # GET /absents/1.json
  def show
  end

  # GET /absents/new
  def new
    @absent = Absent.new
  end

  # GET /absents/1/edit
  def edit
  end

  # POST /absents
  # POST /absents.json
  def create
    @absent = Absent.new(absent_params)

    respond_to do |format|
      if @absent.save
        format.html { redirect_to root_url, notice: 'Absent was successfully created.' }
        format.json { render :show, status: :created, location: @absent }
      else
        format.html { render :new }
        format.json { render json: @absent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /absents/1
  # PATCH/PUT /absents/1.json
  def update
    respond_to do |format|
      if @absent.update(absent_params)
        format.html { redirect_to @absent, notice: 'Absent was successfully updated.' }
        format.json { render :show, status: :ok, location: @absent }
      else
        format.html { render :edit }
        format.json { render json: @absent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /absents/1
  # DELETE /absents/1.json
  def destroy
    @absent.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Absent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_absent
      @absent = Absent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def absent_params
      params.require(:absent).permit!
    end
end
