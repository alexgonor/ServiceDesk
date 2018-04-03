Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end

require 'will_paginate/active_record'
module WillPaginate
  module ActiveRecord
    module RelationMethods
      alias_method :total_count, :count
    end
  end
end
