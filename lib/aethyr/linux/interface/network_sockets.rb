############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ############################################################################################################
    module Interface
    
      ##########################################################################################################
      class NetworkSockets
  
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

            rows = `netstat -unta`.split("\n")
            socks = {};
            rows.each do |r|
              attrs = r.split(/\s+/)
              next unless attrs[0] =~ /^(tcp|udp)/
              local = get_netstat_ip_and_port(attrs[3])
              remote = get_netstat_ip_and_port(attrs[4])
              socks[local[0]] = {:protocol => attrs[0], :local_ip => local[1], :local_port => local[2], :remote_ip => remote[1], 
                                 :remote_port => remote[2], :state => attrs[5]}
            end

            rows = `lsof -i -n`.split("\n")
            rows.shift
            rows.each do |r|
              attrs = r.split(/\s+/)
              local_addr = get_lsof_local_addr(attrs[7])
              socks[local_addr].update(:pid => attrs[1], :fd => attrs[3], :device => attrs[5], :name => attrs[7]) unless socks[local_addr].nil?
            end

            socks.values
            
          end

          ##########################################################################################################
          def get_netstat_ip_and_port(ip_port)
            ip_port = /(.*):(\d+|\*)$/.match(ip_port).to_a
            ip_port[1] = '*' if ip_port[1].eql?('::')
            ip_port[0].gsub!('::','*') if ip_port[0] =~ /^:/
            ip_port
          end

          ##########################################################################################################
          def get_lsof_local_addr(name)
            unless local_addr = /(.*)->.*/.match(name).to_a.last
              local_addr = name
            end
            local_addr = local_addr.split(':')
            local_addr[1] = get_service_port(local_addr[1])
            local_addr.join(':')
          end

          ##########################################################################################################
          def get_service_port(service)
            if @@services.nil?
              @@services = {}
              `cat /etc/services`.split("\n").each do |r|
                attrs = r.split(/\s+/)
                next if attrs[0] =~ /^#/ or attrs.length.eql?(0)
                @@services[attrs[0]] = attrs[1].split('/').first
              end
            end
            @@services[service].nil? ? service : @@services[service]
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
