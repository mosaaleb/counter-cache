# frozen_string_literal: true

require 'test_helper'

module CounterCache
  class MigrationTest < ActiveSupport::TestCase
    fixtures :posts

    test 'initialize raise error if no model was found' do
      assert_raises(ModelNotFound) { Migration.new('Writer').generate }
    end

    test 'sets attr_reader to model name found' do
      instance = Migration.new('Post')
      assert_equal 'Post', instance.send(:model_name)
    end

    test 'add counter cached column with 0 default value to specified model' do
      Post.counter_for :comments
      Migration.new('Post').generate
      post = posts(:one)

      assert_equal 0, post.comments_count
    end
  end
end
