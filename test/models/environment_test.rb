require 'test_helper'

class EnvironmentTest < ActiveSupport::TestCase
  test 'dev environment has versions' do
    dev = environments(:dev)
    assert dev.versions
  end
end
