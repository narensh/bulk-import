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
    @imports = Import.save_all(request.uuid, import_params)
    Thread.new {|_| Import.process(request.uuid)}

    respond_to do |format|
      format.html {redirect_to imports_path, notice: 'Import request accepted.'}
    end
  end

  private

  def import_params
    params.fetch(:import, {})
  end
end