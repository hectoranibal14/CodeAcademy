require 'yaml/store'

class CategoryManager
    
    def initialize
        @category_file = YAML::Store.new 'categorys.yml'
        @category_file.transaction do
            @category_file['category_list'] ||= []
        end
        
        
    end
    
    def add_category(category)
        @category_file.transaction do
            @category_file['category_list'] << category
        end
    end

    def get_all_categorys
        @category_file.transaction { @category_file['category_list'] }
    end

end

