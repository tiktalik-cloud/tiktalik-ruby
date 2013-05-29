def expect_raise(error, message)
  if defined?(default_params)
    expect{ request.call(default_params) }.to raise_error(error, message)
  else
    expect{ request.call }.to raise_error(error, message)
  end
end

shared_examples_for 'support error 400' do
  it "should raise BadRequest error" do
    $faraday_stubs.send(method, url) { [ 400, {}, '400 Bad Request' ] }
    expect_raise(Tiktalik::Error::BadRequest, '400 Bad Request')
  end
end

shared_examples_for 'support error 401' do
  it "should raise Unauthorized error" do
    $faraday_stubs.send(method, url) { [ 401, {}, '401 Not Authorized' ] }
    expect_raise(Tiktalik::Error::Unauthorized, '401 Not Authorized')
  end
end

shared_examples_for 'support error 402' do
  it "should raise PaymentRequired error" do
    $faraday_stubs.send(method, url) { [ 402, {}, '402 Payment Required' ] }
    expect_raise(Tiktalik::Error::PaymentRequired, '402 Payment Required')
  end
end

shared_examples_for 'support error 403' do
  it "should raise Forbidden error" do
    $faraday_stubs.send(method, url) { [ 403, {}, '403 Forbidden' ] }
    expect_raise(Tiktalik::Error::Forbidden, '403 Forbidden')
  end
end

shared_examples_for 'support error 404' do
  it "should raise NotFound error" do
    $faraday_stubs.send(method, url) { [ 404, {}, '404 Not Found' ] }
    expect_raise(Tiktalik::Error::NotFound, '404 Not Found')
  end
end

shared_examples_for 'support error 405' do
  it "should raise NotAllowed error" do
    $faraday_stubs.send(method, url) { [ 405, {}, '405 Not Allowed' ] }
    expect_raise(Tiktalik::Error::NotAllowed, '405 Not Allowed')
  end
end

shared_examples_for 'support error 409' do
  it "should raise Conflict error" do
    $faraday_stubs.send(method, url) { [ 409, {}, '409 Conflict' ] }
    expect_raise(Tiktalik::Error::Conflict, '409 Conflict')
  end
end

shared_examples_for 'support error 500' do
  it "should raise ServerError error" do
    $faraday_stubs.send(method, url) { [ 500, {}, '500 Server Error' ] }
    expect_raise(Tiktalik::Error::ServerError, '500 Server Error')
  end
end
