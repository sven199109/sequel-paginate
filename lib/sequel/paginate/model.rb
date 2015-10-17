module Sequel
  module Paginate 
    module Model 
      def self.included(base)
        base.extend(self)
      end
      def self.extended(base)
        base.instance_eval do
          dataset_module do
            def page(page_no = 1)
              where.extension(:pagination).paginate(page_no, 10)
            end
          end
        end
      end
    end
  end
end
