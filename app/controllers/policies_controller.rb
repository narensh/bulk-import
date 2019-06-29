class PoliciesController < ApplicationController
  before_action :set_policy, only: [:show, :edit, :update, :destroy]

  def index
    @policies = Policy.all
  end

  def show
  end

  def new
    @policy = Policy.new
  end

  def edit
  end

  def create
    @policy = Policy.new(policy_params)

    respond_to do |format|
      if @policy.save
        format.html {redirect_to @policy, notice: 'Policy was successfully created.'}
        format.json {render :show, status: :created, location: @policy}
      else
        format.html {render :new}
        format.json {render json: @policy.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @policy.update(policy_params)
        format.html {redirect_to @policy, notice: 'Policy was successfully updated.'}
        format.json {render :show, status: :ok, location: @policy}
      else
        format.html {render :edit}
        format.json {render json: @policy.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @policy.destroy
    respond_to do |format|
      format.html {redirect_to policies_url, notice: 'Policy was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  def set_policy
    @policy = Policy.find(params[:id])
  end

  def policy_params
    params.require(:policy).permit(:name, :company_id)
  end
end
