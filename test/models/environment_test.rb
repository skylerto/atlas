require 'test_helper'

class EnvironmentTest < ActiveSupport::TestCase
  test 'dev environment has versions' do
    dev = environments(:dev)
    assert dev.versions
  end

  test 'qa find service version' do
    qa = environments(:qa)
    esv = versions('EmailServiceV1.0.0.0')
    es = esv.service
    assert_equal qa.version?(es), esv, ''
  end

  test 'should bump version' do
    qa = environments(:qa)
    esv = versions('EmailServiceV1.0.0.0')
    es = esv.service
    new_version = versions('EmailServiceV1.0.0.1')

    assert_equal qa.version?(es), esv, ''

    qa.bump_version es, new_version

    assert_not_equal qa.version?(es), esv, ''
    assert_equal qa.version?(es), new_version, ''
    assert_not_includes qa.versions, esv
  end
end
