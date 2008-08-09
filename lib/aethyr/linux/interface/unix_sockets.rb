############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ############################################################################################################
    module Interface
    
      ##########################################################################################################
      class UnixSockets
  
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

            rows = `netstat -pnax`.split("\n")
            socks = {};
            rows.each do |r|
              r.tr!('[]', '')
              attrs = r.split(/\s+/)
              next unless attrs[0].eql?('unix')
              sock = self.send("build_hash_length_#{attrs.length}".to_sym, attrs)
              socks[sock[:i_node]] = sock
            end

            rows = `lsof -U`.split("\n")
            rows.shift
            rows.each do |r|
              attrs = r.split(/\s+/)
              socks[attrs[6]].update(:fd => attrs[3], :device => attrs[5], :name => attrs[7]) unless socks[attrs[6]].nil?
            end

            socks.values
          end

          ##########################################################################################################
          def build_hash_length_8(attrs)
            {:ref_cnt => attrs[1], :flags => attrs[2], :socket_type => attrs[3], :state => attrs[4], :i_node => attrs[5], 
             :pid => get_netstat_pid(attrs[6])}
          end

          ##########################################################################################################
          def build_hash_length_7(attrs)
            if UnixSocketTermination.state.include?(attrs[3])
              {:ref_cnt => attrs[1], :socket_type => attrs[2], :state => attrs[3], :i_node => attrs[4], 
               :pid => get_netstat_pid(attrs[5])}
            elsif UnixSocketTermination.state.include?(attrs[4])
              {:ref_cnt => attrs[1], :flags => attrs[2], :socket_type => attrs[3], :state => attrs[4], :i_node => attrs[5], 
               :pid => get_netstat_pid(attrs[6])}
            else
              {:ref_cnt => attrs[1], :flags => attrs[2], :socket_type => attrs[3], :i_node => attrs[4], 
               :pid => get_netstat_pid(attrs[5])}
            end
          end

          ##########################################################################################################
          def build_hash_length_6(attrs)
            if UnixSocketTermination.state.include?(attrs[3])
              {:ref_cnt => attrs[1], :socket_type => attrs[2], :state => attrs[3], :i_node => attrs[4], :pid => get_netstat_pid(attrs[5])}
            elsif UnixSocketTermination.socket_type.include?(attrs[3])
              {:ref_cnt => attrs[1], :flags => attrs[2], :socket_type => attrs[3], :i_node => attrs[4], :pid => get_netstat_pid(attrs[5])}
            else
              {:ref_cnt => attrs[1], :socket_type => attrs[2], :i_node => attrs[3], :pid => get_netstat_pid(attrs[4])}
            end
          end

          ##########################################################################################################
          def build_hash_length_5(attrs)
            {:ref_cnt => attrs[1], :socket_type => attrs[2], :i_node => attrs[3], :pid => get_netstat_pid(attrs[4])}
          end

          ##########################################################################################################
          def get_netstat_pid(a)
            a.eql?('-') ? nil : a.split('/').first
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
