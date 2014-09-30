class StatusesController < ApplicationController
	before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.order('created_at desc').all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statuses }
    end
  end

  # GET /statuses/1
  # GET /statuses/1.json
   def show
    @status = Status.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @status }
    end
  end

  # GET /statuses/new
  def new
    @status = current_user.statuses.new
		@status.build_document

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status }
    end
  end

  # GET /statuses/1/edit
  def edit
    @status = Status.find(params[:id])
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = current_user.statuses.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
        format.json { render :show, status: :created, location: @status }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
		@status = current_user.statuses.find(params[:id])
		@document = @status.document 
		
		@status.transaction do 
			@status.update_attributes(status_params)
			@document.update_attributes(document_params) if @document
			raise ActiveRecord::Rollback unless @status.valid? && @document.try(:valid?)
		end
		
    respond_to do |format|
			format.html { redirect_to @status, notice: 'Status was successfully updated.' }
			format.json { render :show, status: :ok, location: @status }
    end
	rescue ActiveRecord::Rollback 
		respond_to do |format|
			format.html  do 
				flash.now[:error] = "Update failed."
				render action: "edit" 
			end
			format.json { render json: @status.errors, status: :unprocessable_entity }
		end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status = Status.find(params[:id])
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_url, notice: 'Status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params.require(:id))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:content, :attachment,  document_attributes: [:attachment, :remove_attachment] ) if params[:status]
    end
	
		def document_params 
			params.permit(document_attributes: :attachment)
		end
end
