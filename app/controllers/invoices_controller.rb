class InvoicesController < ApplicationController
  before_filter :set_no_of_pre_made_stuff, :only => [:new, :create]
  
  # GET /invoices
  # GET /invoices.xml
  def index
    @invoices = Invoice.order("id ASC").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invoices }
    end
  end

  def unpaid
    @invoices = Invoice.where(:paid => false).order("id ASC").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.xml
  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invoice }
    end
  end

  # GET /invoices/new
  # GET /invoices/new.xml
  def new
    @invoice = nil
    
    if params[:customer_id]
      @invoice = Invoice.new( :customer_id => params[:customer_id] )
    else
      @invoice = Invoice.new
    end
    
    @no_of_pre_made_stuff.times { @invoice.invoice_labours.build }
    @no_of_pre_made_stuff.times { @invoice.invoice_parts.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id])
  end

  # POST /invoices
  # POST /invoices.xml
  def create
    @invoice = Invoice.new(params[:invoice])

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to(@invoice, :notice => 'Invoice was successfully created.') }
        format.xml  { render :xml => @invoice, :status => :created, :location => @invoice }
      else
        if @invoice.invoice_labours.empty?
          @no_of_pre_made_stuff.times { @invoice.invoice_labours.build }
        else
          no_times = @no_of_pre_made_stuff - @invoice.invoice_labours.size
          no_times.times { @invoice.invoice_labours.build }
        end
        
        if @invoice.invoice_parts.empty?
          @no_of_pre_made_stuff.times { @invoice.invoice_parts.build }
        else
          no_times = @no_of_pre_made_stuff - @invoice.invoice_parts.size
          no_times.times { @invoice.invoice_parts.build }
        end
        
        format.html { render :action => "new" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.xml
  def update
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        format.html { redirect_to(@invoice, :notice => 'Invoice was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.xml
  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to(invoices_url) }
      format.xml  { head :ok }
    end
  end
  
  # PUT /invoices/paid
  def paid
    params[:invoice_ids].each do |invoice_id,paid_status|
      invoice = Invoice.find( invoice_id )
      if invoice.paid != paid_status
        invoice.paid = paid_status
        invoice.save
      end
    end
    
    redirect_to(:back)
  end
  
  private 
  
  def set_no_of_pre_made_stuff
    @no_of_pre_made_stuff = 20
  end
end
