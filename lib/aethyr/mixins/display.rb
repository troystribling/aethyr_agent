###########################################################################################################
###########################################################################################################
module Aethyr

  ########################################################################################################
  module Mixins

    ########################################################################################################
    module Display

      ########################################################################################################
      module Helper
          
        ######################################################################################################
        def display_list(model, &block)      
          concat('<div class="display-list-wrapper">', block.binding)
          concat('<table class="display-list">', block.binding)
          yield(model)
          concat('</table>', block.binding)
          concat("</div>", block.binding)
          reset_cycle('display_list')
        end
    
        ######################################################################################################
        def display_list_attribute(a1, a2, options = {})
          attribute_options = {:class => "display-list-attribute"}
          value_options = {:class => "display-list-value"}
          options[:class] = cycle("even", "odd", :name => 'display_list') if options[:class].nil?
          unless a1.kind_of?(String)
            item = content_tag(:td, a2.to_s.humanize.downcase, attribute_options) + content_tag(:td, a1.send(a2), value_options)  
          else
            item = content_tag(:td, a1, attribute_options) + content_tag(:td, a2, value_options)  
          end      
          content_tag :tr, item, options 
        end
    
      ########################################################################################################
      end
  
    ########################################################################################################
    end
  
  ########################################################################################################
  end
  
##########################################################################################################
end