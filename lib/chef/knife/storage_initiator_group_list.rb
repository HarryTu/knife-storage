require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageInitiatorGroupList < Chef::Knife::StorageBase
  banner 'knife storage initiator group list'
  
  common_options
      
  def xio_initiator_group_list                
    begin
      debug_out "Get #{@base_url}/initiator-groups"
      data = JSON.parse @resource['/initiator-groups'].get
    rescue Exception => e
      debug_out e
      err_exit 'Internal error, try again!', 0
    end

    data['initiator-groups'].each do |group|
      puts group['name']  
    end
  end
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_initiator_group_list
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end

end
