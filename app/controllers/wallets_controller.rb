class WalletsController < ApplicationController

  require 'paypal-sdk-rest'
  include PayPal::SDK::REST
# --- !ruby/hash-with-ivars:ActionController::Parameters elements: utf8: "✓" authenticity_token: cYRP5xZwJ62Au57pTQvT71hp2mnJxZiYYYRWPz/vodGDPh6fI2NUN+FS69sgrrIsBTidZ24w7/a8lMK4Pw3bQQ==
# payment_type: Credit Card card_type: Mastercard card_holder_name: sdsad card_number: '11111111111111111111111111111' expiry_month: Month expiry_year: '13' cvv: '11111'
# first_name: 1asda last_name: asd billing_address: asdd amount: '11' description: asdasd commit: save controller: wallets action: init_transaction ivars: :@permitted: false
  def init_transaction
    # raise params.to_yaml

    PayPal::SDK::REST.set_config(
      :mode => "sandbox", # "sandbox" or "live"
      client_id: "Ae-fw4632RySsb8cADQKW9dWjOFCbuHdEecSBh2MIYPZK9Lb0or7TffwNt84tj5ZeMDizTUEgRv_1eBz",
      client_secret: "EKU0rWK1TUmZzwokbgk1C1KIecOqRJziR6xcw1II41yEp4630wl7e7TR_kReO8ah6I3D7AsAqjs8tBHX"
      )

    # Build Payment object
    @payment = Payment.new({
      :intent => "sale",
      :payer => {
        :payment_method => "credit_card",
        :funding_instruments => [{
          :credit_card => {
            :type => params[:card_type],
            :number => params[:card_number],
            :expire_month => params[:expiry_month],
            :expire_year =>params[:expiry_year],
            :cvv2 => params[:cvv],
            :first_name => params[:first_name],
            :last_name => params[:last_name],
           }}]},
          :transactions => [{
        :amount => {
          :total => params[:amount],
          :currency => "USD" },
        :description => "This is the payment transaction description." }]})

        # Create Payment and return the status(true or false)
        if @payment.create
            response = JSON.parse(@payment.to_json)
            transaction_id = response["id"]
            WalletTransaction.create!(:advertiser_id=>current_advertiser.id,:paypal_transaction_id=>transaction_id,:transaction_description=>params[:description],:transaction_amount=>params[:amount])
            flash[:success] = "Successfully added"
            exiting_amount = current_advertiser.wallet_amount
            new_amount = exiting_amount.to_i + params[:amount].to_i
            current_advertiser.update_attributes(:wallet_amount=>new_amount)
            @success = true
            byebug
        else
          @error = @payment.error
          @success = false
        end
  end

end
