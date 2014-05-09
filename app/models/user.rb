class User < ActiveRecord::Base
  self.primary_key = "uid"
  has_many :invites, foreign_key: "uid"
  has_many :events, through: :invites
  has_and_belongs_to_many :events
  
  
  # Omniauth interaction
  def self.from_omniauth(auth)
      where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save!
      end
    end
end
