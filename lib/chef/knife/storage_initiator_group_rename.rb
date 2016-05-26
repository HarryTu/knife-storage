require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageInitiatorGroupRename < Chef::Knife::StorageBase
  banner 'knife storage initiator group rename'
  
  common_options
  
  option :group_name,
         :short => '-g NAME',
         :long  => '--group NAME',
         :description => 'Initiator group name'
  
  option :new_name,
         :short => '-n NAME',
         :long  => '--name NAME',
         :description => 'Initiator group new name'
      
  def xio_initiator_group_rename                
    group_name = get_config('group_name')    
    new_name = get_config('new_name') 
    debug_out "Group name: #{group_name}\nNew Name: #{new_name}"
    if group_name.nil? or new_name.nil?
      err_exit "Initiator group name(-g/--group) and new name(-n/--name) must be specified"
    end
    
    url = '/initiator-groups/?name=' + group_name
    data = "{\"new-name\":\"#{new_name}\"}"
    begin
      debug_out "Post data #{data} to #{@base_url}#{url}"
      @resource[url].put data
    rescue Exception => e
      debug_out e
      err_exit "Internal error, tray again!", 0
    else
      puts "Initiator group #{group_name} is successfully renamed to #{new_name}"
    end
  end
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_initiator_group_rename
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end
end
