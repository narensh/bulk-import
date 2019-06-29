class ImportsController < ApplicationController

  def index
    if params[:request_id]
      @imports = Import.where(request_id: params[:request_id])
    else
      @imports = Import.all
    end
  end

  def show
    @imports = Import.where(request_id: params[:request_id])
  end

  def new
    @import = Import.new
  end

  def create
    begin
      @imports = ImportsHelper.create_imports(request.uuid, import_params)
      message = 'Import request accepted.'
    rescue CSV::MalformedCSVError => e
      message = 'Invalid csv uploaded! Please upload a valid csv.'
    end

    Thread.new {|_| ImportsHelper.process(request.uuid)}

    respond_to do |format|
      format.html {redirect_to imports_path, notice: message}
    end
  end

  private

  def import_params
    params.fetch(:import, {})
  end
end