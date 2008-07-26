class CreateLinuxObjects < ActiveRecord::Migration

  def self.up

    #######################################################################################################
    #### system
    create_table :system, :primary_key => :system_id, :force => true do |t|
      t.string :os
      t.timestamps
    end

    #######################################################################################################
    ####  memory
    create_table :memory, :primary_key => :memory_id, :force => true do |t|
      t.string :machine
      t.string :units
      t.timestamps
    end

    #######################################################################################################
    ####  cpu
    create_table :cpu, :primary_key => :cpu_id, :force => true do |t|
      t.integer :count
      t.string  :frequency
      t.string  :frequency_units
      t.string  :vendor
      t.string  :model
      t.timestamps
    end

    #######################################################################################################
    #### file system
    create_table :disk_partitions, :primary_key => :disk_partition_id, :force => true do |t|
      t.integer :size
      t.integer :file_system_type
      t.timestamps
    end

    create_table :file_systems, :primary_key => :file_system_id, :force => true do |t|
      t.integer :size
      t.integer :mount
      t.timestamps
    end

    #######################################################################################################
    #### applications
    create_table :application_processes, :primary_key => :application_process_id, :force => true do |t|
      t.integer  :f
      t.integer  :pid
      t.boolean  :ni
      t.integer  :sz
      t.integer  :vsz
      t.integer  :sess
      t.integer  :rss
      t.string   :wchan
      t.string   :stat
      t.time     :time
      t.string   :command
      t.float    :pcpu
      t.float    :pmem
      t.datetime :started
      t.integer  :lwp
      t.integer  :nlwp
      t.integer  :psr
      t.integer  :rtprio
      t.timestamps
    end

    create_table :application_threads, :primary_key => :application_thread_id, :force => true do |t|
      t.integer  :f
      t.boolean  :ni
      t.integer  :sz
      t.integer  :vsz
      t.integer  :sess
      t.integer  :rss
      t.string   :wchan
      t.string   :stat
      t.time     :time
      t.string   :command
      t.float    :pcpu
      t.float    :pmem
      t.datetime :started
      t.integer  :lwp
      t.integer  :nlwp
      t.integer  :psr
      t.integer  :rtprio
      t.timestamps
    end

    create_table :unix_socket_terminations, :primary_key => :unix_socket_termination_id, :force => true do |t|
      t.integer  :node
      t.integer  :refcnt
      t.string   :command
      t.string   :type
      t.string   :state
      t.string   :fd
      t.timestamps
    end

    create_table :pipe_terminations, :primary_key => :pipe_termination_id, :force => true do |t|
      t.integer  :size
      t.integer  :node
      t.integer  :nlink
      t.string   :command
      t.string   :type
      t.string   :fd
      t.timestamps
    end

    create_table :file_terminations, :primary_key => :file_termination_id, :force => true do |t|
      t.integer  :size
      t.integer  :node
      t.integer  :nlink
      t.string   :command
      t.string   :type
      t.string   :fd
      t.timestamps
    end

    create_table :tcp_socket_terminations, :primary_key => :tcp_termination_id, :force => true do |t|
      t.integer  :node
      t.integer  :refcnt
      t.string   :command
      t.string   :type
      t.string   :state
      t.string   :fd
      t.string   :local_address
      t.integer  :local_port
      t.string   :remote_address
      t.integer  :remote_port
      t.timestamps
    end

    create_table :memory_terminations, :primary_key => :memory_termination_id, :force => true do |t|
      t.timestamps
    end

    create_table :cpu_terminations, :primary_key => :cpu_termination_id, :force => true do |t|
      t.timestamps
    end


    #######################################################################################################
    #### network
    create_table :nics, :primary_key => :nic_id, :force => true do |t|
      t.string :mac_address
      t.string :ip_address
      t.integer :physical_id
      t.timestamps
    end

    create_table :network_interfaces, :primary_key => :network_interface_id, :force => true do |t|
      t.timestamps
    end

    #######################################################################################################
    #### users
    create_table :system_users, :primary_key => :system_user_id, :force => true do |t|
      t.integer :uid
      t.string :full_name
      t.string :office
      t.string :extension
      t.string :home_phone
      t.string :home_directory
      t.string :login_shell
      t.timestamps
    end

    create_table :system_user_terminations, :primary_key => :system_user_termination_id, :force => true do |t|
      t.timestamps
    end

    create_table :system_groups, :primary_key => :system_group_id, :force => true do |t|
      t.integer :gid
      t.timestamps
    end

    #######################################################################################################
    #### software
    create_table :software_repositories, :primary_key => :software_repository_id, :force => true do |t|
      t.timestamps
    end

    create_table :packages, :primary_key => :package_id, :force => true do |t|
      t.timestamps
    end

    create_table :gems, :primary_key => :gem_id, :force => true do |t|
      t.timestamps
    end

  end

  #######################################################################################################
  def self.down

    #### hardware
    drop_table :system
    drop_table :cpus
    drop_table :memory

    #### file system
    drop_table :disk_partitions
    drop_table :file_systems

    #### applications
    drop_table :application_processes
    drop_table :application_threads
    drop_table :unix_socket_terminations
    drop_table :pipe_terminations
    drop_table :file_terminations
    drop_table :memory_terminations
    drop_table :cpu_terminations
    drop_table :tcp_socket_terminations

    #### network
    drop_table :nics
    drop_table :network_interfaces

    #### users
    drop_table :system_users
    drop_table :system_user_terminations
    drop_table :system_groups

    #### software
    drop_table :software_repositories
    drop_table :packages
    drop_table :gems

  end
  
end
