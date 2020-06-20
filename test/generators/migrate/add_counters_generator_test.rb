# frozen_string_literal: true

require 'test_helper'

module CounterCache
  module Generators
    class AddCountersGeneratorTest < Rails::Generators::TestCase
      tests AddCountersGenerator
      destination File.expand_path('tmp', __dir__)
      setup :prepare_destination

      test 'raise ModelNotFound if no model found' do
        assert_raises(ModelNotFound) do
          run_generator %w[article comments_count]
        end
      end

      test 'raise MissingColumn if attribute is\'nt defined in model' do
        assert_raises(MissingColumn) do
          run_generator %w[post bla_count]
        end
      end

      # test 'should create migration file for specified model name' do
      #   run_generator %w[post comments_count]
      #   assert_migration 'db/migrate/add_comments_count_to_post.rb'
      # end

      # test 'raise error '
    end
  end
end

# assert_file "app/mailers/notifier.rb" do |mailer|
# assert_match(/class Notifier < ActionMailer::Base/, mailer)
# assert_match(/default from: "from@example.com"/, mailer)
# end
