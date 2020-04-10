# frozen_string_literal: true

require 'test_helper'

class HasCounterCacheTest < ActiveSupport::TestCase
  test 'add instance class array of all cached columns' do
    assert_equal [], Post.counter_cached_columns
  end
end
