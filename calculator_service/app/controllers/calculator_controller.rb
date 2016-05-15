require 'net/http'
require "uri"

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



		uri = URI('=http://aviator1.cloudapp.net/imc/calcular')
		req = Net::HTTP::Post.new(uri, initheader = {'Content-Type' =>'application/json'})
		req.body = {"peso": @peso, "altura": @altura}.to_json
		res = Net::HTTP.start(uri.hostname, uri.port) do |http|
  		http.request(req)
		end


		#uri = URI('http://aviator1.cloudapp.net/imc/calcular')
		#response = Net::HTTP.post_form(uri, "peso" => @peso, "altura" => @altura )

		@imc = res
	end

end
