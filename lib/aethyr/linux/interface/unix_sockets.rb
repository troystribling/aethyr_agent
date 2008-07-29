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
              if attrs.length.eql?(5)
                sock = build_hash_length_5(r)
              elsif attrs.length.eql?(6)
                sock = build_hash_length_6(r)
              elsif attrs.length.eql?(7)
                sock = build_hash_length_7(r)
              elsif attrs.length.eql?(8)
                sock = build_hash_length_8(r)
              end
              socks[sock[:i_node]] = sock
            end
          end

          ##########################################################################################################
          def build_hash_length_8(r)
            {:ref_cnt => r[1], :unix_socket_flags => r[2], :unix_socket_type => r[3], :unix_socket_state => r[4], :i_node => r[5], 
             :pid => get_pid(r[6]), :name => r[7]}
          end

          ##########################################################################################################
          def build_hash_length_7(r)
            if UnixSocketTermination.unix_socket_state.include?(r[3])
              {:ref_cnt => r[1], :unix_socket_type => r[2], :unix_socket_state => r[3], :i_node => r[4], 
               :pid => get_pid(r[5]), :name => r[6]}
            elsif UnixSocketTermination.unix_socket_state.include?(r[4])
              {:ref_cnt => r[1], :unix_socket_flags => r[2], :unix_socket_type => r[3], :unix_socket_state => r[4], :i_node => r[5], 
               :pid => get_pid(r[6])}
            else
              {:ref_cnt => r[1], :unix_socket_flags => r[2], :unix_socket_type => r[3], :i_node => r[4], 
               :pid => get_pid(r[5]), :name => r[6]}
            end
          end

          ##########################################################################################################
          def build_hash_length_6(r)
            if UnixSocketTermination.unix_socket_state.include?(r[3])
              {:ref_cnt => r[1], :unix_socket_type => r[2], :unix_socket_state => r[3], :i_node => r[4], :pid => get_pid(r[5])}
            elsif UnixSocketTermination.unix_socket_type.include?(r[3])
              {:ref_cnt => r[1], :unix_socket_flags => r[2], :unix_socket_type => r[3], :i_node => r[4], :pid => get_pid(r[5])}
            else
              {:ref_cnt => r[1], :unix_socket_type => r[2], :i_node => r[3], :pid => get_pid(r[4]), :name => r[5]}
            end
          end

          ##########################################################################################################
          def build_hash_length_5(r)
            {:ref_cnt => r[1], :unix_socket_type => r[2], :i_node => r[3], :pid => get_pid(r[4])}
          end

          ##########################################################################################################
          def get_pid(a)
            a.split('/').first
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
