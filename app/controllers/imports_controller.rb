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
      Thread.new {|_| ImportsHelper.process(request.uuid)}
    rescue CSV::MalformedCSVError => e
      message = 'Invalid csv uploaded! Please upload a valid csv.'
    rescue Exceptions::CompanyNotFoundException
      message = 'Company is required for this upload. Please select company.'
    rescue StandardError => e
      message = 'An Unhandled Exception occurred. Please reach out to support team.'
      Rails.logger.error(e)
    end

    respond_to do |format|
      format.html {redirect_to imports_path, notice: message}
    end
  end

  private

  def import_params
    params.fetch(:import, {})
  end
end