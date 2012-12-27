class ExpensesController < ApplicationController
  #Service tab
  set_tab :financial
  #Resource tab
  set_tab :all, :expenses
  #sub-tab, each sub-tab coresponse to one action, they belong to the namespace 'expense_actions'
  set_tab :list, :expense_actions, :only => %w(index)
  set_tab :add, :expense_actions, :only => %w(new)
  
  # GET /expenses
  # GET /expenses.json
  def index
    #default is the current month
    !params[:year] ? @year = Date.today.year : @year = params[:year]
    !params[:month] ? @month = Date.today.month : @month = params[:month]
    begin_date = Date.parse("#{@year}-#{@month}-01")
    end_date = begin_date.end_of_month
    #inclusive search
    @expenses = Expense.find(:all, :conditions=>["exp_date BETWEEN DATE(?) AND DATE(?)", begin_date, end_date], :order=>:exp_date)
    @monthly_total = Expense.sum(:amount, :conditions=>["exp_date BETWEEN DATE(?) AND DATE(?)", begin_date, end_date])
    @summaries = Expense.sum(:amount, :conditions=>["exp_date BETWEEN DATE(?) AND DATE(?)", begin_date.prev_month, end_date.prev_month], :group=>:exp_type_id)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    @expense = Expense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.json
  def new
    load_selections
    @expense = Expense.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense }
    end
  end

  # Ajax called to render additional fields depending on the expense type selected
  def select_type
    type = ExpType.find(:first, :select=>'description', :conditions=>{:id=>params[:expense][:exp_type_id]})
    if type != nil && type == 'Anual bill'
      render :partial => 'date_range', :layout => false
    end
  end

  # GET /expenses/1/edit
  def edit
    load_selections
    @expense = Expense.find(params[:id])
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(params[:expense])

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render json: @expense, status: :created, location: @expense }
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.json
  def update
    @expense = Expense.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :ok }
    end
  end
  
  # GET /expenses/1/breakdown
  def breakdown
    load_selections
    
    @parent_expense = Expense.find(params[:id])
    @expense = Expense.new
  end
  
  # PUT /expenses/1/update_breakdown
  def update_breakdown
    @parent_expense = Expense.find(params[:id])
    @expense = Expense.new(params[:expense])
    error = false
#    flash[:error] = nil
    if(params[:expense].amount.to_f >= @parent_expense.amount.to_f)
      flash[:error] = 'Sub-amount can not exceed parent amount.'
      error = true
      puts "888888888888 " + params[:expense].amount.to_f.to_s
      puts "----------- " + @parent_expense.amount.to_f.to_s
    end
    if (params[:expense].payment_type_id.to_i != @parent_expense.payment_type_id.to_i)
      flash[:error] = 'Sub-expense must have the same payment method as parent expense.'
      error = true
      puts "888888888888 " + params[:expense].payment_type_id.to_s
      puts "----------- " + @parent_expense.payment_type_id.to_s
    end
    if error == false
      begin
        Expense.transaction do
          @parent_expense.update_attribute(:amount, (@parent_expense.amount - @expense.amount))
          @expense.save
          redirect_to(expenses_path)
        end
      rescue ActiveRecord::RecordInvalid => e
        flash[:error] = e.message
        load_selections
        render :action=>'breakdown'
      end
    else
      load_selections
      render :action=>'breakdown'
    end
  end

private
  def load_selections
    @exp_types = ExpType.all
    @payment_types = PaymentType.all
  end
end