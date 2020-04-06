# frozen_string_literal: true

require 'test_helper'

class HasCounterCacheTest < ActiveSupport::TestCase
  def setup
    @post = Post.new(text: 'John Snow is back!')
  end

  test 'has empty array of counter cached columns' do
    assert_equal [], @post.counter_cached_columns
  end
end
