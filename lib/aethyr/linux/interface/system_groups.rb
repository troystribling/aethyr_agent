############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ############################################################################################################
    module Interface
    
      ##########################################################################################################
      class SystemGroups
      
        ######################################################################################################
        #### class methods
        class << self
  
          ########################################################################################################
          def find(type = :all, options = {})
            if type.eql?(:first)
            else
              self.find_all
            end
          end
    
          ##########################################################################################################
          def find_all
            groups = `cat /etc/group`
            groups.split("\n").collect do |g|
              ga = g.split(':')
              ga[3].nil? ? su = [] : su = ga[3].split(',')
              {:name => ga[0], :gid => ga[2], :system_users => su}
            end
          end
    
        ######################################################################################################
        end  
        
      ##########################################################################################################
      end
  
    ##########################################################################################################
    end

  ##########################################################################################################
  end
  
##########################################################################################################
end