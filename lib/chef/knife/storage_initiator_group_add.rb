require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageInitiatorGroupAdd < Chef::Knife::StorageBase
  banner 'knife storage initiator group add'
  
  common_options
  
  option :group_name,
         :short => '-g NAME',
         :long  => '--group NAME',
         :description => 'Initiator group name'
      
  def xio_initiator_group_add                
    group_name = get_config('group_name') 
    debug_out "Group name: #{group_name}"
    if group_name.nil?
      err_exit "Group name must be specified through -g/--group"
    end
    
    data = "{\"ig-name\":\"#{group_name}\"}"
    begin
      debug_out "Post data #{data} to #{@base_url}/initiator-groups"
      @resource['/initiator-groups'].post data
    rescue Exception => e
      debug_out e
      err_exit("Internal error, tray again!", 0)
    else
      puts "Initiator group #{group_name} is successfully created"
    end
  end
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_initiator_group_add
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end
end
