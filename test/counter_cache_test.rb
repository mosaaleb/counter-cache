# frozen_string_literal: true

require 'test_helper'

class CounterCache::Test < ActiveSupport::TestCase
  test 'truth' do
    assert_kind_of Module, CounterCache::HasCounterCache
  end
end
