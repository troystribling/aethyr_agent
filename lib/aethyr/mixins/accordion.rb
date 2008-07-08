##########################################################################################################
##########################################################################################################
module Aethyr

  ########################################################################################################
  module Mixins

    ########################################################################################################
    module Accordion
      
      ########################################################################################################
      ########################################################################################################
      module Helper
      
        ######################################################################################################
        def accordion(args, &block)      
          args.assert_valid_keys(:class)
          accordion_class = args[:class].to_s + '-accordion'
          concat("<div class = #{accordion_class}>", block.binding)
          yield args
          concat("</div>", block.binding)
         end
  
        ######################################################################################################
        def accordion_item(args, &block)      
          args.assert_valid_keys(:class, :title, :open)
          accordion_class = args[:class].to_s + '-accordion'
          title_options = {:class => "#{accordion_class}-title"}
          content_options = {:class => "#{accordion_class}-content"}
          args[:open].nil? ? is_open = false : is_open = args[:open]
          is_open ? title_options[:class] += " open" : content_options.update(:style => "display: none;")
          concat(content_tag(:h2, args[:title], title_options), block.binding)
          content = content_tag(:div, content_options) do
            capture(&block) if block_given?
          end
          concat(content, block.binding)
        end
          
      end
      
    end
  
  end
    
end