class EnvPresenter
  def initialize()
  end

  def secret_key
    Rails.application.credentials.secret_code
  end
end
