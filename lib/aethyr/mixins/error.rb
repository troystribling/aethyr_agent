##############################################################################################################
##############################################################################################################
module Aethyr

  ############################################################################################################
  module Mixins

    ############################################################################################################
    module Error
  
      ##########################################################################################################
      def ajax_validation_errors(model, partial = 'common/display_validation_errors', &blk)
        show_errors('validation-errors', model, partial, &blk)
      end
  
      ##########################################################################################################
      def aws_errors(msg, partial = 'common/display_aws_errors', &blk)
        show_errors('aws-errors', msg, partial, &blk)
      end
  
      ##########################################################################################################
      def show_errors(error_id, obj, partial)
        respond_to do |format|
          block_given? ? format.html {yield} : format.html {redirect_to(services_path)}
          format.js do
            render :update do |page|
              page[error_id].hide
              page[error_id].replace_html :partial => partial, :object => obj
              page[error_id].visual_effect :blind_down, :duration => 1
            end
          end
        end
      end
  
      ##########################################################################################################
      def redirect_on_error(msg, target, target_object = nil)
        respond_to do |format|
          format.html {redirect_to(services_path)}
          format.js do
            show_redirect_error(msg, target, target_object)
          end
        end
      end
  
      ##########################################################################################################
      def show_redirect_error(msg, target, target_object = nil)
        render :update do |page|
          page['services-display'].replace_html :partial => target , :object => target_object
          page['aws-errors'].hide
          page['aws-errors'].replace_html :partial => 'common/redirect_notice', :object => msg
          page['aws-errors'].visual_effect :blind_down, :duration => 1
        end
      end
  
      ##########################################################################################################
      def ajax_sync_errors(msg, div='validation-errors', partial = 'common/display_sync_errors')
        respond_to do |format|
         format.html {redirect_to(services_path)}
         format.js do
           render :update do |page|
             page[div].hide
             page[div].replace_html :partial => partial, :object => msg
             page[div].visual_effect :blind_down, :duration => 1
           end
         end
        end
      end
    
    ############################################################################################################
    end

  ############################################################################################################
  end

##############################################################################################################
end