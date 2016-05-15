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

		params = {:peso => @peso, :altura => @altura}

		response = post "http://aviator1.cloudapp.net/imc/calcular", params.to_json, {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}

		@imc = response.body
	end

end
