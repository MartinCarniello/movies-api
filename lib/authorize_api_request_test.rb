class AuthorizeApiRequestTest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    if @headers['Authorization']
      { user: User.first }
    else
      raise(ExceptionHandler::MissingToken, Message.missing_token)
    end
  end
end