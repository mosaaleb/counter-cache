# frozen_string_literal: true

require 'test_helper'

class CounterCache::Test < ActiveSupport::TestCase
  test 'is a module' do
    assert_kind_of Module, CounterCache::HasCounterCache
  end

  test 'has a version' do
    assert_not_nil CounterCache::VERSION
  end
end
