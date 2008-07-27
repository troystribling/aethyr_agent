############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ############################################################################################################
    module Interface
    
      ##########################################################################################################
      class Pipes
  
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
            rows = `ls -l /dev`.split("\n")
            rows.collect do |r|
              attrs = r.split(/\s+/)
              {:name => attrs[8], :last_updated => "#{attrs[6]} #{attrs[7]}", :major_number => attrs[4], :minor_number => attrs[5], 
               :links => attrs[1], :device_type => /^(\w).*/.match(attrs[0]).to_a.last, :owner => attrs[2], :group => attrs[3]}
            end.select{|r| r[:device_type].eql?('p')}          
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
