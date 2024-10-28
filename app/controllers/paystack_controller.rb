# class PaystackController < ApplicationController
#   skip_before_action :verify_authenticity_token, only: [:webhook]

#   # def callback
#   #   render json: { message: 'Test Callback URL received successfully' }
#   # end

#     def callback

#       data = {
#         user_id: params[:user_id],
#         amount: params[:amount],
#         transaction_id: params[:transaction_id]

#       }


#       http = Net::HTTP.new(uri.host, uri.port)
#       request = Net::HTTP::Post.new(uri.path)
#       request.set_form_data(data)

#       response = http.request(request)

#       render json: { message: 'Deposit creation triggered successfully', response: response.body }
#     end


#     def webhook
#       head :ok
#     end
# end
