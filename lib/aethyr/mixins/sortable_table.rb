##########################################################################################################
##########################################################################################################
module Aethyr

  ########################################################################################################
  ########################################################################################################
  module Mixins

    ########################################################################################################
    ########################################################################################################
    module SortableTable
      
      ########################################################################################################
      ########################################################################################################
      module Helper
      
        ######################################################################################################
        def has_sortable_table(args = {})
        
          args.assert_valid_keys(:model, :update)
          model = args[:model].to_s
    
          class_eval <<-do_eval
              
            def #{model.pluralize}_sort_link(args)
  
              args.assert_valid_keys(:column, :text, :supporter, :controller)
  
              table_column = args[:column].to_s
              supporter = args[:supporter]
              controller = args[:controller] || :#{model.pluralize}
              session_key = :#{model.pluralize}_sortable_table
              text = args[:text] || table_column.humanize.downcase   
  
              session[session_key] = {:column => table_column, :sort => 'sort-up', :page => 1} if session[session_key].nil?
              sort = session[session_key][:sort].eql?('sort-down') ? 'sort-up' : 'sort-down'
              url = {:controller => controller, :action => :#{model.pluralize}_list, :column => table_column, :sort => sort}
  
              unless supporter.nil?
                supporter_id = supporter.class.name.underscore + "_id"
                supporter_id = supporter_id.to_sym
                url.update(supporter_id => supporter.send(supporter_id))
              end  
  
              link_options = {
                  :url => url,
                  :before    => "$('loading-indication').show()" ,
                  :complete  => "$('loading-indication').hide()" 
              }
  
              content_tag :th, :class => table_column.eql?(session[session_key][:column]) ? sort : '' do 
                link_to_remote(text, link_options)    
              end      
  
            end
  
          do_eval
                 
        end
      
      ########################################################################################################
      end  #### Helper
      ##########################################################################################################
          
      ########################################################################################################
      ########################################################################################################
      module Controller

        ########################################################################################################
        ########################################################################################################
        module InstanceMethods

          ########################################################################################################
          def initialize_sortable_table_session(args)
            args.assert_valid_keys(:session_key, :column, :sort, :force)
            args[:force].nil? ? force = true : force = args[:force]
            table_is_new = false
            unless session[args[:session_key]]
              session[args[:session_key]] = {}
              table_is_new = true
            end 
            if table_is_new or force
              session[args[:session_key]][:column] = args[:column]
              session[args[:session_key]][:sort] = args[:sort]
              session[args[:session_key]][:page] = 1
            end
          end

        ########################################################################################################
        end  #### InstanceMethods
        ##########################################################################################################

        ########################################################################################################
        ########################################################################################################
        module ClassMethods

          ######################################################################################################
          def responds_to_sortable_table(args = {})
          
            args.assert_valid_keys(:model, :search, :paginate, :partial, :object, :update, :supporter)
            model = args[:model].to_s
            search = args[:search] || false
            paginate = args[:paginate] || false
            partial = args[:partial] || "#{model.pluralize}"
            object = args[:object] || "@#{model.pluralize}"
            update = args[:update] || "#{model.pluralize}-list"
            session_key = ":#{model.pluralize}_sortable_table"
            supporter = args[:supporter] unless args[:supporter].nil?
            
            ######################################################################################################
            class_eval <<-do_eval
    
              def initialize_#{model.pluralize}_list(args)            
                self.initialize_sortable_table_session(args.merge(:session_key => #{session_key}))
                @search = session[#{session_key}][:search]
                #{model.pluralize}_sortable_table_data
              end
              
              def #{model.pluralize}_list   
                if #{model.camelize}.column_names_hierarchy.include?(params[:column])
                  respond_to do |format|
                    format.html {redirect_to(#{model.pluralize}_path)}
                    format.js do
                      initialize_#{model.pluralize}_list(:column => params[:column], :sort => params[:sort])
                      render :update do |page|
                        page['#{update}'].replace_html :partial => '#{partial}', :object => #{object}
                      end
                    end
                  end
                else
                  respond_to do |format|
                    format.html {redirect_to(#{model.pluralize}_path)}
                    format.js do
                      render :update do |page|
                        page['#{update}'].replace_html content_tag(:h2, 'sort column is invalid.')
                      end
                    end
                  end 
                end
              end
      
              def self.#{model}_sortable_table_order(session)
                column = session[#{session_key}][:column]
                #{model.camelize}.ancestor_for_attribute(column.to_sym).name.tableize + '.' + column + 
                  lambda{session[#{session_key}][:sort].eql?('sort-up') ? ' DESC' : ' ASC'}.call
              end
              
            do_eval
                    
            ######################################################################################################
            if search.eql?(true)
      
              class_eval <<-do_eval
      
                def #{model.pluralize}_search
                  session[#{session_key}][:search] = params[:search]
                  session[#{session_key}][:page] = 1
                  #{model.pluralize}_sortable_table_data
                  respond_to do |format|
                    format.html {redirect_to(services_path)}
                    format.js do
                      render :update do |page|
                        page['#{update}'].replace_html :partial => '#{partial}', :object => #{object}
                      end
                    end
                  end
                end
    
                def self.build_search_query_for_column(table, column, value) 
                 filter = '%' + value + '%'
                 table + '.' + column + ' LIKE ' + ActiveRecord::Base.connection.quote(filter)
                end
                    
                def self.#{model}_conditions_by_like(value)
                  unless value.blank? 
                    '(' + #{model.camelize}.column_names_hierarchy.collect do |c| 
                      self.build_search_query_for_column(#{model.camelize}.ancestor_for_attribute(c.to_sym).name.tableize, c, value)
                    end.join(" OR " ) + ')'
                  else
                    ""
                  end
                end
      
              do_eval
            
            end        
      
            ######################################################################################################
            if paginate
            
              class_eval <<-do_eval  
              
                def #{model.pluralize}_change_page
                  session[#{session_key}][:page] = params[:page]
                  #{model.pluralize}_sortable_table_data
                  respond_to do |format|
                    format.html {redirect_to(services_path)}
                    format.js do
                      render :update do |page|
                        page.replace_html '#{update}', :partial => '#{partial}', :object => #{object}
                      end
                    end
                  end
                end          
              do_eval
      
              unless supporter.nil?
                class_eval <<-do_eval
                  def #{model.pluralize}_sortable_table_data
                    @#{model.pluralize} = self.class.paginate_in_support_hierarchy_by_model(self.#{supporter}, session)
                  end
                do_eval
              end
      
            end
                    
            ######################################################################################################
            if search.eql?(true) and not paginate
      
              unless supporter.nil?
                class_eval <<-do_eval
                  def #{model.pluralize}_sortable_table_data
                    @#{model.pluralize} = self.#{supporter}.find_in_support_hierarchy_by_model(#{model.camelize}, :all, 
                      :order => self.class.#{model}_sortable_table_order(session), :select => '*', 
                      :conditions => #{model}_conditions_by_like(session[#{session_key}][:search]))
                  end
                do_eval            
              else
                class_eval <<-do_eval
                  def #{model.pluralize}_sortable_table_data
                    @#{model.pluralize} = #{model.camelize}.find_by_model(:all, :order => self.class.#{model}_sortable_table_order(session), 
                      :select => '*', :conditions => #{model}_conditions_by_like(session[#{session_key}][:search]))
                  end
                do_eval
              end
    
            ######################################################################################################
            elsif paginate and search.eql?(false)
            
              unless supporter.nil?
                class_eval <<-do_eval
                  def self.paginate_in_support_hierarchy_by_model(supporter, session)
                    supporter.paginate_in_support_hierarchy_by_model(#{model.camelize}, :per_page => #{paginate}, 
                      :page => session[#{session_key}][:page], 
                      :order => self.#{model}_sortable_table_order(session))
                  end
                do_eval
              else
                class_eval <<-do_eval
                  def #{model.pluralize}_sortable_table_data
                    @#{model.pluralize} = #{model.camelize}.paginate(:per_page => #{paginate}, 
                      :page => session[#{session_key}][:page], 
                      :order => self.class.#{model}_sortable_table_order(session))
                  end
                do_eval
              end
                  
            ######################################################################################################
            elsif paginate and search.eql?(true)
    
              unless supporter.nil?
                class_eval <<-do_eval
                  def self.paginate_in_support_hierarchy_by_model(supporter, session)
                    supporter.paginate_in_support_hierarchy_by_model(#{model.camelize}, :per_page => #{paginate}, 
                      :page => session[#{session_key}][:page], :select => '*', 
                      :order => self.#{model}_sortable_table_order(session), 
                      :conditions => #{model}_conditions_by_like(session[#{session_key}][:search]))
                  end
                do_eval
              else
                class_eval <<-do_eval
                  def #{model.pluralize}_sortable_table_data
                    @#{model.pluralize} = #{model.camelize}.paginate(:per_page => #{paginate}, 
                      :page => session[#{session_key}][:page], :select => '*', 
                      :order => self.class.#{model}_sortable_table_order(session), 
                      :conditions => self.class.#{model}_conditions_by_like(session[#{session_key}][:search]))
                  end 
                do_eval
              end
                  
            ######################################################################################################
            else
            
              unless supporter.nil?
                class_eval <<-do_eval          
                  def #{model.pluralize}_sortable_table_data
                    @#{model.pluralize} = self.#{supporter}.find_in_support_hierarchy_by_model(#{model.camelize},:all, 
                      :order => self.class.#{model}_sortable_table_order(session))
                  end
                do_eval
              else
                class_eval <<-do_eval          
                  def #{model.pluralize}_sortable_table_data
                    @#{model.pluralize} = #{model.camelize}.find_by_model(:all, :order => self.class.#{model}_sortable_table_order(session))
                  end
                do_eval
              end            
      
            end
            
          end  
      
        ########################################################################################################
        end  #### ClassMethods
        ##########################################################################################################

      ########################################################################################################
      end  #### Controller
      ##########################################################################################################
    
    ########################################################################################################
    end  #### SortableTable
    ##########################################################################################################

  ########################################################################################################
  end  #### Mixins
  ##########################################################################################################
  
##########################################################################################################
end  #### Aethyr
##########################################################################################################
