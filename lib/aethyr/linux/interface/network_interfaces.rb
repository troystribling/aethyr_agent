############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ############################################################################################################
    module Interface
    
      ##########################################################################################################
      class NetworkInterfaces
  
        ######################################################################################################
        #### class attributes
        @@services = nil
        
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

            rows = `ifconfig -a`.split("\n")
            rows = rows.collect{|r| r.split(/\s+/)}
            ifaces = []
            row = 0
            until row >= rows.length
              iface_type = /^(\D+)/.match(rows[row][0]).to_a.last
              iface_type.nil? ? row += 1 : row = self.send("build_#{iface_type}".to_sym, row, rows, ifaces)
            end
            
            ifaces
            
          end

          ##########################################################################################################
          def build_eth(row, rows, ifaces) 
            ifaces << build_common(row, rows).merge(:hw_address => rows[row][4],
                                                    :interrrupt => get_attr_value(rows[row+8][1]), 
                                                    :base_address => get_attr_value(rows[row+8][3]),
                                                    :broadcast_address  => get_attr_value(rows[row+1][3]),
                                                    :mask => get_attr_value(rows[row+1][4]))
            row += 9            
          end

          ##########################################################################################################
          def build_lo(row, rows, ifaces) 
            ifaces << build_common(row, rows).merge(:hw_address => rows[row][3], 
                                                    :mask => get_attr_value(rows[row+1][3]))
            row += 7
          end

          ##########################################################################################################
          def build_common(row, rows) 
            {
             :name               => rows[row][0],
             :link_encapsulation => get_attr_value(rows[row][2]),
             :ip_address         => get_attr_value(rows[row+1][2]),
             :ipv6_address       => rows[row+2][3],
             :scope              => get_attr_value(rows[row+2][4]),
             :status             => rows[row+3][1..rows[row+3].length-3].join(' '),
             :mtu                => get_attr_value(rows[row+3][rows[row+3].length-2]),
             :metric             => get_attr_value(rows[row+3][rows[row+3].length-1]),
             :txqueuelen         => get_attr_value(rows[row+6][2]),
            }
          end

          ##########################################################################################################
          def get_attr_value(attr)
            attr.split(":").last
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
