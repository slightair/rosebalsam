require 'securerandom'

class User < ActiveRecord::Base
  has_many :tokens

  after_create :create_token

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['nickname']
    end
  end

  def create_token
    tokens.active.update_all(deleted_at: Time.now)
    loop do
      new_token = SecureRandom.hex(20)
      return tokens.create(token: new_token) if Token.where(token: new_token).empty?
    end
  end

  def token
    tokens.active.first.try(:token)
  end
end
