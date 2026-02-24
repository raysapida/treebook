class StatusesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  def index
    params[:page] ||=1
    if user_signed_in?
      @statuses = Status.where.not(user: current_user.blocked_friends).
        order('created_at desc').
        paginate(:page => params[:page]).includes(:user, :document)
    else
      @statuses = Status.order('created_at desc').
        paginate(:page => params[:page]).includes(:user, :document)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statuses }
    end
  end

  def show
    @status = Status.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @status }
    end
  end

  def new
    @status = current_user.statuses.new
    @status.build_document

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status }
    end
  end

  def edit
    @status = Status.find(params[:id])
  end

  def create
    @status = current_user.statuses.new(status_params)

    respond_to do |format|
      if @status.save
        current_user.create_activity(@status, 'created')
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
        format.json { render :show, status: :created, location: @status }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    status = current_user.statuses.find(params[:id])
    document = status.document

    status.transaction do
      status.update!(status_params)
      document.update!(document_params) if document
      current_user.create_activity(status, 'updated')
    end

    respond_to do |format|
      redirect_url  = status_path(status)
      format.html { redirect_to redirect_url, :only_path => true , notice: 'Status was successfully updated.' }
      format.json { render :show, status: :ok, location: status }
    end
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
      format.html  do
        flash.now[:error] = "Update failed."
        render action: "edit"
      end
      format.json { render json: status.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @status = Status.find(params[:id])
    @status.destroy
    current_user.create_activity(@status, 'deleted')
    respond_to do |format|
      format.html { redirect_to statuses_url, notice: 'Status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_status
    @status = Status.find(params.require(:id))
  end

  def status_params
    params.require(:status).permit(:content, :attachment,  document_attributes: [:attachment, :remove_attachment] ) if params[:status]
  end

  def document_params
    params.permit(document_attributes: :attachment)
  end
end
