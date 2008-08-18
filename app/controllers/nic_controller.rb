########################################################################################################
########################################################################################################
class NicController < ApplicationController

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::MonomodelControllerHelper
  include Aethyr::Aln::SupporterControllerHelper

  ######################################################################################################
  #### default layout
  layout 'agent'

  ######################################################################################################
  #### supported models
  has_supported :models => :network_interface_terminations, :sort_column => 'name'

  ######################################################################################################
  #### filters
  before_filter :find_nic, :only => [:show]
  before_filter :find_network_interface_terminations, :only=>[:show]
  before_filter :set_root_page_of_click_path, :only => [:show]

########################################################################################################
protected
        
end
