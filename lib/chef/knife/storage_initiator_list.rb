require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageInitiatorList < Chef::Knife::StorageBase
  banner 'knife storage initiator list'
  
  common_options
    
  def xio_initiator_list          
    begin
      debug_out "Get #{@base_url}/initiators"
      data = JSON.parse @resource['/initiators'].get
    rescue Exception => e
      debug_out e
      err_exit "Internal error, try again!", 0
    end
    
    data['initiators'].each do |initiator|
      puts "#{initiator['name']}" unless initiator['name'].nil? or initiator['name'].empty?
    end
  end
  
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_initiator_list
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end

end
