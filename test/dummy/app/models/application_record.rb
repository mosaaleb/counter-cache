# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include CounterCache::HasCounterCache

  self.abstract_class = true
end
