require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageTargetList < Chef::Knife::StorageBase
  banner 'knife storage target list'
  
  common_options
    
  def xio_target_list          
    begin
      debug_out "Get #{@base_url}/targets"
      data = JSON.parse @resource['/targets'].get
    rescue Exception => e
      debug_out e
      err_exit "Internal error, try again!", 0
    end
    
    data['targets'].each do |target|
      puts target['name']
    end
  end
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_target_list
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end

end
