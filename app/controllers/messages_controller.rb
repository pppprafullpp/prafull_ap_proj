class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def get_messages
    @messages = Message.where(:message_to_type=>params[:type],:message_to_id=>params[:id])
    render :json=> {
      success:true,
      messages:@messages
    }
  end
end
