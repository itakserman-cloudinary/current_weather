class User < ApplicationRecord
    has_many :user_location_settings
    has_many :locations, through: :user_location_settings

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    
    def full_name
        "#{first_name} #{last_name}"
    end
end
