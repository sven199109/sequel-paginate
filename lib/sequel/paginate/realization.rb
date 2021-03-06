require 'sequel/model'
module Sequel
  module Paginate 
    module Realization
      def self.included(base)
        base.extend(self)
      end

      def self.extended(base)
        class << base 
          def paginate_per(count = 20)
            @paginate_per ||= count
          end
        end
        base.class_eval do
          dataset_module do
            define_method(:page) do |*args, &block|
              begin
                page_per = args[1][:page_per]
              rescue
                page_per = nil
              end
              page_no = args[0].to_i
              page_no = page_no > 0 ? page_no : 1
              where.extension(:pagination).paginate(page_no.to_i, page_per || self.model.paginate_per)
            end
          end
        end
      end
    end
  end
end

Sequel::Model.include ::Sequel::Paginate::Realization
