class CalculatorController < ApplicationController

	def new
    @firstValue = params["firstValue"].to_f
    @secondValue = params["secondValue"].to_f
    @type = params["type"]

    operation = Operation.new( params["type"], @firstValue, @secondValue)
    @result = operation.calculate()
  end

  def create
    operation = Operation.new( params[:type], params[:firstValue], params[:secondValue])
    result = operation.calculate()
    respond_to do |format|
      msg = { :type => params[:type], :firstValue => params[:firstValue], :secondValue => params[:secondValue], :result => result }
      format.json  { render :json => msg }
    end
  end

  def index
  end

end
