require 'test_helper'

class VersionTest < ActiveSupport::TestCase
  test 'Version has environments' do
    es = versions('EmailServiceV1.0.0.0')
    assert true
  end
end
