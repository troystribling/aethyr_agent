##########################################################################################################
##########################################################################################################
module Aethyr

  ########################################################################################################
  module Mixins

    ########################################################################################################
    module Navigator
      
      ########################################################################################################
      ########################################################################################################
      module Helper
      
        ######################################################################################################
        def navigate_to_remote_with_load_notifier(name, options, select = nil)
          if select.eql?(name) or (options[:url][:action].eql?(@current_action) and options[:url][:controller].eql?(@current_controller))
            content_tag(:strong, name)
          else
            link_to_remote_with_load_notifier(name, options)
          end
        end        
  
        ######################################################################################################
        def navigate_to(name, url)
          current_url = url_for(:controller => @current_controller, :action => @current_action, :only_path => true)
          url = [url] unless url.kind_of?(Array);
          if url.include?(current_url)
            content_tag(:strong, name)
          else
            link_to(name, url.first)
          end
        end        
  
        ######################################################################################################
        def list_of_navigate_to_remote_with_load_notifier(links, select = nil)
          list_items = ''
          links.each do |l| 
            list_items += content_tag :li do
              navigate_to_remote_with_load_notifier(l[:text], l[:options], select)               
            end
          end  
          list_items += content_tag(:div, '', :class => 'clear')   
          content_tag :ul, list_items
        end
  
        ######################################################################################################
        def list_of_navigate_to(links, select = nil)
          list_items = ''
          links.each do |l| 
            list_items += content_tag :li do
              navigate_to l[:text], l[:url], select                
            end
          end        
          list_items += content_tag(:div, '', :class => 'clear')   
          content_tag :ul, list_items
        end
  
        ######################################################################################################
        def list_click_path_with_load_notifier
          list_items = ''        
          (0..session[:click_path].size-2).each do |click|
            url = session[:click_path][click]
            url[:action].eql?('edit') ? name = url[:controller].humanize.singularize.downcase : name = url[:action].humanize.downcase
            name = ' &laquo ' + name
            list_items += content_tag :li do
              link_to_remote_with_load_notifier(name, :url => url.merge(:click_path => click))
            end
          end        
          content_tag(:ul, list_items)
        end
  
      ########################################################################################################
      end
  
      ########################################################################################################
      ########################################################################################################
      module Controller
      
        ########################################################################################################
        def set_root_page_of_click_path
          session[:click_path] = [prepare_click_path_item]
        end
  
        ########################################################################################################
        def force_root_page_of_click_path(click_path)
          session[:click_path] = [click_path]
        end
      
        ########################################################################################################
        def prune_click_path
          session[:click_path].pop unless session[:click_path].nil?
        end
  
        ########################################################################################################
        def add_page_to_click_path
          selected_click = request.parameters[:click_path]
          if selected_click.nil?
            session[:click_path] << prepare_click_path_item unless session[:click_path].nil?         
          else
            session[:click_path] = session[:click_path].slice(0, selected_click.to_i + 1)
          end
        end
  
        ########################################################################################################
        def prepare_click_path_item
          path_item = request.parameters
          path_item.except(:authenticity_token)
        end
      
      ########################################################################################################
      end
    
    ##########################################################################################################
    end

  ##########################################################################################################
  end
    
############################################################################################################
end