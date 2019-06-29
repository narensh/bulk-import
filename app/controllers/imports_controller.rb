class ImportsController < ApplicationController
  # GET /imports
  # GET /imports.json
  def index
    if params[:request_id]
      @imports = Import.where(request_id: params[:request_id])
    else
      @imports = Import.all
    end
  end

  # GET /imports/1
  # GET /imports/1.json
  def show
    @imports = Import.where(request_id: params[:request_id])
  end

  # GET /imports/new
  def new
    @import = Import.new
  end

  # GET /imports/1/edit
  def edit
  end

  # POST /imports
  # POST /imports.json
  def create
    Import.save_all(request.uuid, import_params)

    Thread.new {|t| Import.process(request.uuid)}
    respond_to do |format|
      format.html {redirect_to imports_path, notice: 'Import request accepted.'}
      format.json {render :show, status: :created, location: @import}
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def import_params
    params.fetch(:import, {})
  end
end