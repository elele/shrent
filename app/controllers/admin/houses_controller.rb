class Admin::HousesController < ApplicationController
  # GET /admin/houses
  # GET /admin/houses.json
  def index
    @admin_houses = House.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_houses }
    end
  end

  # GET /admin/houses/1
  # GET /admin/houses/1.json
  def show
    @admin_house = House.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_house }
    end
  end

  # GET /admin/houses/new
  # GET /admin/houses/new.json
  def new
    @admin_house = House.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_house }
    end
  end

  # GET /admin/houses/1/edit
  def edit
    @admin_house = House.find(params[:id])
  end

  # POST /admin/houses
  # POST /admin/houses.json
  def create
    @admin_house = House.new(params[:admin_house])

    respond_to do |format|
      if @admin_house.save
        format.html { redirect_to @admin_house, notice: 'House was successfully created.' }
        format.json { render json: @admin_house, status: :created, location: @admin_house }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_house.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/houses/1
  # PUT /admin/houses/1.json
  def update
    @admin_house = House.find(params[:id])

    respond_to do |format|
      if @admin_house.update_attributes(params[:admin_house])
        format.html { redirect_to @admin_house, notice: 'House was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/houses/1
  # DELETE /admin/houses/1.json
  def destroy
    @admin_house = House.find(params[:id])
    @admin_house.destroy

    respond_to do |format|
      format.html { redirect_to admin_houses_url }
      format.json { head :no_content }
    end
  end
end
