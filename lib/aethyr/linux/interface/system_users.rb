############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ############################################################################################################
    module Interface
    
      ##########################################################################################################
      class SystemUsers
      
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
            users = `cat /etc/passwd`
            users.split("\n").collect do |u|
              ua = u.split(':')
              gecos = ua[4].split(',')
              {:name => ua[0], :uid => ua[2], :default_gid => ua[3], :home_directory => ua[5], :login_shell => ua[6], 
               :full_name => gecos[0], :office => gecos[1], :extension => gecos[2], :home_phone => gecos[3]}
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
