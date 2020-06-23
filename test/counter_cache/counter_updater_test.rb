# frozen_string_literal: true

require 'test_helper'

module CounterCache
  class CounterUpdaterTest < ActiveSupport::TestCase
    fixtures :posts, :comments, :likes

    def setup
      ActiveRecord::Schema.verbose = false
      ActiveRecord::Schema.define do
        add_column :posts, :likes_count, :integer, default: 0
        add_column :posts, :approves_count, :integer, default: 0
        add_column :posts, :comments_count, :integer, default: 0
        add_column :posts, :opinions_count, :integer, default: 0
      end
    end

    class WithNoClassNameDefinedContext < CounterUpdaterTest
      def setup
        Post.counter_for :likes
        Post.counter_for :comments
        super
      end

      test 'define increment and decrement callbacks for child objects' do
        like = likes(:one)
        comment = comments(:one)
        refute_nil comment.run_callbacks(:create)
        refute_nil comment.run_callbacks(:destroy)
        refute_nil like.run_callbacks(:create)
        refute_nil like.run_callbacks(:destroy)
      end

      test 'increment child model counter column when created' do
        post = posts(:one)
        post.likes.create
        assert_equal 1, post.reload.likes_count
      end

      test 'decrement child model counter column when destroyed' do
        post = posts(:one)
        like = post.likes.create
        assert_equal 1, post.reload.likes_count

        like.destroy
        assert_equal 0, post.reload.likes_count
      end
    end

    class WithClassNameDefinedContext < CounterUpdaterTest
      def setup
        Post.counter_for :approves, class_name: :Like
        Post.counter_for :opinions, class_name: :Comment
        super
      end

      test 'define increment and decrement callbacks' do
        like = likes(:one)
        refute_nil like.run_callbacks(:create)
        refute_nil like.run_callbacks(:destroy)
      end

      test 'increment childmodel counter column when created' do
        post = posts(:one)
        post.comments.create
        assert_equal 1, post.reload.opinions_count
      end

      test 'decrement child model counter column when destroyed' do
        post = posts(:one)
        like = post.likes.create
        assert_equal 1, post.reload.approves_count

        like.destroy
        assert_equal 0, post.reload.approves_count
      end
    end
  end
end
