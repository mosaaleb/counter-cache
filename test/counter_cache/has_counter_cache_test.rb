# frozen_string_literal: true

require 'test_helper'

module CounterCache
  class HasCounterCacheTest < ActiveSupport::TestCase
    test 'add instance class array of all cached columns' do
      assert_equal [], Post.counter_cached_columns
    end

    test 'counter_for add arguments to counter_cached_columns' do
      Post.counter_for :comments
      assert_equal [:comments], Post.counter_cached_columns
    end

    test 'counter_for only appends arguments if unique' do
      Post.counter_for :comments, :comments, :likes
      assert_equal %i[comments likes], Post.counter_cached_columns
    end
  end
end
