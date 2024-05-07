# frozen_string_literal: true
require 'logging/logs'

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include Logging::Logs
end
