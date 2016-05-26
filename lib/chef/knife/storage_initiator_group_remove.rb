require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageInitiatorGroupRemove < Chef::Knife::StorageBase
  banner 'knife storage initiator group remove'
  
  common_options
  
  option :group_name,
         :short => '-g NAME',
         :long  => '--group NAME',
         :description => 'Initiator group name'
      
  def xio_initiator_group_remove                
    group_name = get_config('group_name') 
    debug_out "Group name: #{group_name}"
    if group_name.nil?
      err_exit "Initiator group name must be specified through -g/--group"
    end
    
    url = '/initiator-groups/?name=' + group_name
    begin
      debug_out "Delete #{@base_url}#{url}"
      @resource[url].delete
    rescue Exception => e
      debug_out e
      err_exit("Internal error, try again!", 0)
    else
      puts "Initiator group #{group_name} is successfully removed"
    end
  end
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_initiator_group_remove
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end
end
