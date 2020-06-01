# frozen_string_literal: true

require 'test_helper'

module CounterCache
  class CounterUpdaterTest < ActiveSupport::TestCase
    fixtures :posts, :comments, :likes

    def setup
      Post.counter_for :comments, :likes
    end

    test 'define increment and decrement callbacks for comment object' do
      comment = comments(:one)
      refute_nil comment.run_callbacks(:create)
      refute_nil comment.run_callbacks(:destroy)
    end

    test 'define increment and decrement callbacks for like object' do
      like = likes(:one)
      refute_nil like.run_callbacks(:create)
      refute_nil like.run_callbacks(:destroy)
    end

    test 'increment childmodel counter column when created' do
      post = posts(:one)
      post.comments.create(text: 'some comment')
      assert_equal 1, post.reload.comments_count
    end

    test 'decrement child model counter column when destroyed' do
      post = posts(:one)
      like = post.likes.create
      assert_equal 1, post.reload.likes_count

      like.destroy
      assert_equal 0, post.reload.likes_count
    end
  end
end
