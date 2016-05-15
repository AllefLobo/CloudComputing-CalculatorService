require "uri"
require "net/http"
require 'json'

class CalculatorController < ApplicationController

	def new
    @firstValue = params["firstValue"].to_f
    @secondValue = params["secondValue"].to_f
    @type = params["type"]

		if @secondValue == 0.0
			@result = 0.0
		else
    	operation = Operation.new( params["type"], @firstValue, @secondValue)
    	@result = operation.calculate()
		end
  end

  def create
		@firstValue = params["firstValue"].to_f
    @secondValue = params["secondValue"].to_f
    @type = params["type"]

		if @secondValue == 0.0
			result = 0.0
		else
			operation = Operation.new( @type, @firstValue, @secondValue)
			result = operation.calculate()
		end

    respond_to do |format|
      msg = { :type => @type, :firstValue => @firstValue, :secondValue => @secondValue, :result => result }
      format.json  { render :json => msg }
    end
  end

  def index
  end

	def imc
		@peso = params["peso"].to_f
		@altura = params["altura"].to_f

		response = curl -H "Content-Type: application/json" -X POST -d '{"peso": 94, "altura":1.64}' http://aviator1.cloudapp.net/imc/calcular

		@imc = response
	end

end
