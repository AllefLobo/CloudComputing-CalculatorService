require 'net/http'
require 'json'

class CalculatorController < ApplicationController

	def new
    @firstValue = params["firstValue"].to_f
    @secondValue = params["secondValue"].to_f
    @type = params["type"]

		if @secondValue == 0.0 @type == "divide"
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

		if @secondValue == 0.0 && @type == "divide"
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

		url = "http://aviator1.cloudapp.net/imc/calcular"
		payload = {"peso"=> @peso, "altura"=> @altura}.to_json

		require 'net/http'
		request = Net::HTTP::Post.new(url)
		request.add_field "Content-Type", "application/json"
		request.body = payload

		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		response = JSON.parse( (http.request(request)).body )

		@resultadoImc = response["imc"]
	end

end
