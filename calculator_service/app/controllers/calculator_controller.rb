require 'net/http'

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

		@toSend = {
    "peso" => @peso,
    "altura" => @altura
		}.to_json

		uri = URI.parse("http://aviator1.cloudapp.net/imc/calcular")
		https = Net::HTTP.new(uri.host,uri.port)
		https.use_ssl = true
		req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
		req.body = "[ #{@toSend} ]"
		res = https.request(req)

		@imc = res

	end

end
