class Client < ActiveRecord::Base
  scope :active, -> { where(deleted_at: nil) }

  def callback_url_with(token)
    params = {
        token: token
    }
    "#{callback_url}?#{params.to_param}"
  end
end
