########################################################################################################
########################################################################################################
class Log < ActiveRecord::Base

  ######################################################################################################
  #### inheritance relations
  has_descendants

  ######################################################################################################
  #### associations
  belongs_to :resource_with_log

  ######################################################################################################
  #### valdators
  validates_presence_of :name
   
end