class Influencer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  PLATFORMS = {"Facebook"=>1,"Instagram"=>2, "Both" => 3}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_one :social_account
    has_many :advertisements


    def self.online?
      if self.last_sign_in_at < 10.minutes.from_now
        true
      else
        false
      end
    end

end
