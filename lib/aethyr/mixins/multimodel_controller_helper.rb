###########################################################################################################
#### Aethyr mixin for synchronizing aws models
###########################################################################################################
module Aethyr

  ########################################################################################################
  #### Mixins
  ########################################################################################################
  module Mixins

    ########################################################################################################
    #### methods added to controllers
    ########################################################################################################
    module MultimodelControllerHelper

      ######################################################################################################
      def self.included(base) 

        controller = base.controller_name
        model = controller.singularize
          
        base.class_eval <<-do_eval 

          def edit
            respond_to do |format|
              format.js do
                render :update do |page|
                  page['display-click-path-wrapper'].show
                  page['display-click-path'].replace_html :partial => 'common/click_path'
                  page['agent-display'].replace_html :partial => 'edit'
                end
              end
            end
          end
        
          def #{controller}_summary
            initialize_#{controller}_list(:column => 'created_at', :sort => 'sort-up', :force => false)
            respond_to do |format|
              format.js do
                render :update do |page|
                  page['agent-display'].replace_html :partial => '#{controller}_summary'
                  page['display-click-path-wrapper'].hide
                  page << "SearchInputMgr.loadSearchInput('/#{controller}/#{controller}_search');"              
                end
              end
            end
          end
        
          def find_#{model}
            model_id = params[:#{model}_id] || params[:id]
            @#{model} = #{model.camelize}.find_by_model(model_id, :readonly => false)
            if @#{model}.nil?
              respond_to do |format|
                format.html {redirect_to(system_index_path)}
                format.js do
                  render :update do |page|
                    page.redirect_to system_index_path 
                  end
                end
              end
            end 
          end
          
        do_eval

      end           

    ########################################################################################################
    end #### MultimodelControllerHelper
    ########################################################################################################

  ########################################################################################################
  end #### Mixins
  ########################################################################################################

############################################################################################################
end #### Aethyr
############################################################################################################
    