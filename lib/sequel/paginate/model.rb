module Sequel
  module Paginate 
    module Model 
      def self.extended(base)
        eigen_class = class << base; self; end
        eigen_class.instance_eval do
          p "HEHEDA"
          p self
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
