class JokesController < ApplicationController
  before_filter :login_required
  before_filter :admin_required, :only => [:new, :edit, :create, :update, :destroy]

  # GET /jokes
  # GET /jokes.xml
  def index
    @jokes = Joke.not_purchased_by_company(current_user.company)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jokes }
    end
  end
  
  # GET /jokes/my
  # GET /jokes/my.xml
  def my
    @purchases = current_user.company.purchases
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jokes }
    end
  end
  
  # GET /jokes/1
  # GET /jokes/1.xml
  def show
    @joke = Joke.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @joke }
    end
  end

  # GET /jokes/new
  # GET /jokes/new.xml
  def new
    @joke = Joke.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @joke }
    end
  end

  # GET /jokes/1/edit
  def edit
    @joke = Joke.find(params[:id])
  end

  # GET /jokes/1/checkout
  # GET /jokes/1/checkout.xml
  def checkout
    create_purchase

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @joke }
    end
  end
  
  # POST /jokes/1/purchase
  # POST /jokes/1/purchase.xml
  def purchase
    create_purchase

    respond_to do |format|
      if @purchase.save
        flash[:notice] = 'Joke was successfully purchased.'
        format.html { redirect_to(@purchase.joke) }
        format.xml  { render :xml => @purchase.joke, :status => :created, :location => @purchase.joke }
      else
        format.html { render :action => "checkout" }
        format.xml  { render :xml => @purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /jokes
  # POST /jokes.xml
  def create
    @joke = Joke.new(params[:joke])

    respond_to do |format|
      if @joke.save
        flash[:notice] = 'Joke was successfully created.'
        format.html { redirect_to(@joke) }
        format.xml  { render :xml => @joke, :status => :created, :location => @joke }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @joke.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jokes/1
  # PUT /jokes/1.xml
  def update
    @joke = Joke.find(params[:id])

    respond_to do |format|
      if @joke.update_attributes(params[:joke])
        flash[:notice] = 'Joke was successfully updated.'
        format.html { redirect_to(@joke) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @joke.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jokes/1
  # DELETE /jokes/1.xml
  def destroy
    @joke = Joke.find(params[:id])
    @joke.destroy

    respond_to do |format|
      format.html { redirect_to(jokes_url) }
      format.xml  { head :ok }
    end
  end
  
  
private
  def create_purchase
    @purchase = Purchase.new
    @purchase.joke = Joke.find(params[:id])
    @purchase.user = current_user
    @purchase.company = current_user.company
  end
end
