###########################################################################################################
###########################################################################################################
module Aethyr

  ########################################################################################################
  module Mixins

    ########################################################################################################
    module Helpers
      
      ######################################################################################################
      def validation_errors
        content_tag :div, :id => "validation-errors" do 
        end
      end
  
      ######################################################################################################
      def aws_errors
        content_tag :div, :id => "aws-errors" do 
        end
      end
  
      ######################################################################################################
      def format_timestamp(timestamp, options = {})
        options[:class] = 'timestamp' if options[:class].nil? 
        content_tag :span, timestamp.strftime("%Y-%m-%d %H:%M:%S"), options
      end
  
      ######################################################################################################
      def disable_submit_to_remote_with_synchronize_notifier(disable_on, tag, options = {})
        options.update(:html => {:disabled  => true}) if disable_on.nil?
        submit_to_remote_with_synchronize_notifier(tag, options)
      end
  
      ######################################################################################################
      def disable_submit_to_remote_with_load_notifier(disable_on, tag, options = {})
        options.update(:html => {:disabled  => true}) if disable_on.nil?
        submit_to_remote_with_load_notifier(tag, options)
      end
  
      ######################################################################################################
      def format_rsa_key(value)
        format_new_line(value, "\n", 'rsa_key')
      end
  
      ######################################################################################################
      def format_headers(value)
        format_new_line(value, "\\n", 'headers')
      end
  
      ######################################################################################################
      def format_console_output(value)
        value.gsub!(/\xd/, '')
        value.gsub!(/\x8+/, "\n")
        value.gsub!(/\x1b/, '')
        format_new_line(value, "\n", 'display-console-line')
      end

      ######################################################################################################
      def format_new_line(value, delimiter, css_class)
        fmt_value = ''  
        if value
          value.split(delimiter).each do |v|   
            fmt_value += content_tag(:div, v, :class => css_class)
          end
        end
        fmt_value 
      end
  
      ######################################################################################################
      def display_flash(page, type)
        flash_id = "display-#{type.to_s}"
        page[flash_id].hide
        page[flash_id].replace_html flash[type]
        page[flash_id].visual_effect :blind_down, :duration => 1
      end
  
      ######################################################################################################
      def link_to_remote_with_load_notifier(tag, options = {})
        options.update(:before => "$('loading-indication').show()", :complete  => "$('loading-indication').hide()")
        link_to_remote(tag, options) 
      end
  
      ######################################################################################################
      def submit_to_remote_with_load_notifier(name, options = {})
        options.update(:before => "$('loading-indication').show()", :complete  => "$('loading-indication').hide()")
        submit_to_remote("#{name}_button", name, options) 
      end
  
      ######################################################################################################
      def cancel_to_previous_request(request)
        submit_to_remote_with_load_notifier('cancel', :url => AccessLog.previous_request(request))
      end
  
      ######################################################################################################
      def submit_to_remote_with_synchronize_notifier(name, options = {})
        options.update(:before => "$('synchronizing-indication').show()", :complete  => "$('synchronizing-indication').hide()")
        submit_to_remote("#{name}_button", name, options) 
      end
       
      ######################################################################################################
      def labeled_form_for(name, *args, &block)
        options = args.last.is_a?(Hash) ? args.pop : {}
        options = options.merge(:builder => LabeledTextBuilder)
        args << options
        form_for(name, *args, &block)
      end
  
      ######################################################################################################
      def labeled_remote_form_for(name, *args, &block)
        options = args.last.is_a?(Hash) ? args.pop : {}
        options = options.merge(:builder => LabeledTextBuilder)
        args << options
        remote_form_for(name, *args, &block)
      end
  
      ######################################################################################################
      def block_to_partial(partial_name, options = {}, &block)
        options.merge!(:body => capture(&block))
        concat(render(:partial => partial_name, :locals => options), block.binding)
      end
  
      ######################################################################################################
      def search_text_field(value, options = {})
        text_field_tag('search', value , options)
      end
  
    ########################################################################################################
    end
  
  ########################################################################################################
  end
  
##########################################################################################################
end