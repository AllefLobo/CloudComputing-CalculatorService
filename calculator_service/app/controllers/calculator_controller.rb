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

		uri = URI.parse("http://ec2-52-37-59-164.us-west-2.compute.amazonaws.com:3000/calculator")

		http = Net::HTTP.new(uri.host, uri.port)

		request = Net::HTTP::Post.new(uri.request_uri)
		request.set_form_data({"type"=> "sum", "firstValue"=> 10 , "secondValue" => 3})

		response = http.request(request)
		@resultadoImc = render :json => response.body

	end

end
