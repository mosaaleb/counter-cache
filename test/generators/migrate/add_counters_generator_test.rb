# frozen_string_literal: true

require 'test_helper'

module CounterCache
  module Generators
    class AddCountersGeneratorTest < Rails::Generators::TestCase
      tests AddCountersGenerator
      destination File.expand_path('tmp', __dir__)
      setup :prepare_destination

      test 'raise ModelNotFound if no model found' do
        assert_raises ModelNotFound do
          run_generator %w[article comments]
        end
      end

      test 'raise MissingColumn if attribute is\'nt defined in model' do
        assert_raises MissingColumn do
          run_generator %w[post bla]
        end
      end

      test 'migration file should be created' do
        Comment.counter_for :likes

        run_generator %w[comment likes]
        assert_migration 'db/migrate/add_likes_count_to_comments.rb'
      end

      test 'migration skeleton should have the right information' do
        Post.counter_for :comments
        run_generator %w[post comments]

        assert_migration 'db/migrate/add_comments_count_to_posts.rb' do |f|
          assert_match(/AddCommentsCountToPosts < ActiveRecord::Migration/, f)
          assert_match(/add_column :posts, :comments_count, :integer/, f)
          assert_match(/default: 0/, f)
          assert_match(/add_index :posts, :comments_count/, f)
        end
      end
    end
  end
end
