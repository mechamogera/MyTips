class ReportsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
    @user = current_user

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reports }
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @report = Report.find_by_id(params[:id])
    raise BlogException.new(:not_found, "not find request page") unless @report

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report }
    end
  rescue => e
    @message = e.message
    status = (e.class == BlogException ? e.code : :internal_server_error)
    respond_to do |format|
      format.html { render :template => 'error', :status => status }
      format.json { render json: @message, :status => status  }
    end
  end

  # GET /reports/new
  # GET /reports/new.json
  def new
    @report = Report.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @report }
    end
  end

  # GET /reports/1/edit
  def edit
    @report = Report.find_by_id(params[:id])
    raise BlogException.new(:not_found, "not find request page") unless @report
    raise BlogException.new(:not_found, "not find request page") unless @report.accessible?(current_user)
  rescue => e
    @message = e.message
    status = (e.class == BlogException ? e.code : :internal_server_error)
    respond_to do |format|
      format.html { render :template => 'error', :status => status }
      format.json { render json: @message, :status => status  }
    end
  end

  # POST /reports
  # POST /reports.json
  def create
    @user = current_user
    @report = @user.reports.build
    @report.attributes = params[:report]

    respond_to do |format|
      if @user.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render action: "new" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reports/1
  # PUT /reports/1.json
  def update
    @report = Report.find_by_id(params[:id])
    raise BlogException.new(:not_found, "not find request page") unless @report
    raise BlogException.new(:not_found, "not find request page") unless @report.accessible?(current_user)

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  rescue => e
    @message = e.message
    status = (e.class == BlogException ? e.code : :internal_server_error)
    respond_to do |format|
      format.html { render :template => 'error', :status => status }
      format.json { render json: @message, :status => status  }
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report = Report.find_by_id(params[:id])
    raise BlogException.new(:not_found, "not find request page") unless @report
    raise BlogException.new(:not_found, "not find request page") unless @report.accessible?(current_user)
    
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url }
      format.json { head :no_content }
    end
  rescue => e
    @message = e.message
    status = (e.class == BlogException ? e.code : :internal_server_error)
    respond_to do |format|
      format.html { render :template => 'error', :status => status }
      format.json { render json: @message, :status => status  }
    end
  end
end
