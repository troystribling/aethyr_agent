############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ##########################################################################################################
    class HardwareInventory

      ######################################################################################################
      #### class methods
      class << self

        ##########################################################################################################
        def synchronize
          self.system_synchronize
          self.memory_synchronize
          self.cpu_synchronize
          self.nic_synchronize
        end
        
        ##########################################################################################################
        def system_synchronize
          
          @@system = System.new(:name => `hostname`, :os => `uname -a`)
          @@system.save
        end
  
        ##########################################################################################################
        def memory_synchronize
          MemoryTermination.destroy_all
          attrs = /MemTotal:\s*(\d+)\s(\w+)/.match(`cat /proc/meminfo`)
          Memory.new(:name => 'Memory', :machine => attrs[1], :units => attrs[2]).add_associations(@@system)
        end
  
        ##########################################################################################################
        def cpu_synchronize
          get_val = lambda{|r| /^.+:\s(.+)/.match(r).to_a.last}
          get_units = lambda{|r| /^cpu(\w+):/.match(r).to_a.last}
          rows = `cat /proc/cpuinfo`.split("\n")
          Cpu.new(:name => 'CPU', :count => rows.length/19, :frequency => get_val[rows[6]], :frequency_units => get_units[rows[6]],  
            :model =>  get_val[rows[4]], :vendor => get_val[rows[1]]).add_associations(@@system)
        end
  
        ##########################################################################################################
        def nic_synchronize
          hw = XmlSimple.xml_in(`lshw -xml`, {'KeyAttr' => {'node' => 'id', 'capability' => 'id', 'setting' => 'id'}, 'forcearray' => false})
          network = hw['node']['node']['pci']['node']['pci:1']['node']['network']
          Nic.new(:name => network['logicalname'], :mac_address => network['serial'], 
                  :ip_address => network['configuration']['setting']['ip']['value'], :physical_id => network['physid']).add_associations(@@system)
        end

      ######################################################################################################
      end  
      
    ##########################################################################################################
    end

  ##########################################################################################################
  end
  
##########################################################################################################
end
