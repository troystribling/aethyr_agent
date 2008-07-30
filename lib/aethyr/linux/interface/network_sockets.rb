############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ############################################################################################################
    module Interface
    
      ##########################################################################################################
      class NetworkSockets
  
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
          
        ######################################################################################################
        protected
    
          ##########################################################################################################
          def find_all

            rows = `netstat -unta`.split("\n")
            socks = {};
            rows.each do |r|
              attrs = r.split(/\s+/)
              next unless attrs[0] =~ /^(tcp|udp)/
              
            end

            rows = `lsof -i -n`.split("\n")
            rows.shift
            rows.each do |r|
              attrs = r.split(/\s+/)
            end

            socks.values
            
          end

          ##########################################################################################################
          def get_ip_and_port(ip_port)
            ip_port.split(':')
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
