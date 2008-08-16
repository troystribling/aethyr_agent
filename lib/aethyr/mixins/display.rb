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
        def display_control(model, &block)      
          concat('<div class="display-control-wrapper">', block.binding)
            yield(model)
          concat("</div>", block.binding)
        end
    
        ######################################################################################################
        def display_header(args, &block)      

          args.assert_valid_keys(:title, :name, :model)

          model = args[:model]
          title = args[:title] || model.class.name.underscore.humanize.downcase
          name = args[:name] || model.name 

          if block_given?
            concat("<h1>#{title}: <em>#{name}</em></h1>", block.binding)
            concat('<hr class=display-top">', block.binding)
            yield(model)
            concat('<hr class=display-divide">', block.binding)
          else
            page_out  = content_tag :h1 do
              "#{title}: " + content_tag(:em, "#{name}")
            end 
            page_out + tag(:hr, {:class => 'display-top'}) + tag(:hr, {:class => 'display-divide'})
          end
        

        end

        ######################################################################################################
        def display_buttons(args = {}, &block)      

          args.assert_valid_keys(:model)

          model = args[:model]

          if block_given?
            concat('<hr class=display-divide">', block.binding)
            yield(model)
            concat('<hr class=display-bottom">', block.binding)
          else
            tag(:hr, {:class => 'display-divide'}) + tag(:hr, {:class => 'display-bottom'})
          end

        end

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
        def display_model(model, &block)      
          concat("<tr class=#{cycle("even", "odd", :name => 'display_model')}>", block.binding)
            yield(model)
          concat("</tr>", block.binding)
        end

        ######################################################################################################
        def display_model_attribute(attr)
          content_tag :td, attr
        end

        ######################################################################################################
        def display_models(args, &block)      

          args.assert_valid_keys(:models, :paginate)

          models = args[:models]          
          model = models.first.class.name.underscore

          paginate = args[:paginate] || true
          controller = args[:controller] || model.pluralize
          action = "#{model.pluralize}_change_page"

          concat('<table class="table-data">', block.binding)
            concat('<tr>', block.binding)
              yield
            concat('</tr>', block.binding)          
            concat(render(:partial => "#{controller}/#{model}", :collection => models), block.binding)  
          concat('</table>', block.binding)

          if paginate
            pag_browse = will_paginate(models, :params=> {:controller => "#{controller}", :action => "#{action}"})            
            unless pag_browse.nil?
              concat('<div class="bottom-toolbar">', block.binding)
                concat(pag_browse, block.binding)
              concat('</div>', block.binding)
            end
          end

          reset_cycle('display_model')
          
        end

        ######################################################################################################
        def display_models_summary(args)

          args.assert_valid_keys(:models, :controller, :search, :title)

          models = args[:models]
          model = models.first.class.name.underscore
          search = args[:search] || true
          controller = args[:controller] || model.pluralize
          title = args[:title] || controller.humanize.downcase + ' summary'

          page_out = content_tag(:h1, title) + tag(:hr, {:class => 'page-divide'})                    
          page_out << render(:partial => "common/search", :object => {:model => "#{model}", :search_value => @search}) if search
          page_out << tag(:hr, {:class => 'page-top'})          
          page_out << content_tag(:div, {:id => "#{controller}-list"}) do 
            render(:partial => "#{controller}/#{model.pluralize}") unless models.empty? 
          end
          page_out << tag(:hr, {:class => 'page-bottom'})
          
          page_out 
          
        end
      
      ########################################################################################################
      end
  
    ########################################################################################################
    end
  
  ########################################################################################################
  end
  
##########################################################################################################
end