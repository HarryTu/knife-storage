require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageVolumeRemove < Chef::Knife::StorageBase
  banner 'knife storage volume remove'
  
  common_options
  
  option :vol_name,
         :short => '-n NAME',
         :long => '--name NAME',
         :description => 'The volume name'
  
  #option :vol_id,
  #       :short => '-i ID',
  #       :long => '--id ID',
  #       :description => 'The volume ID'
  
  def xio_volume_remove
    vol_name = get_config('vol_name')
    debug_out "Volume name: #{vol_name}"
    if vol_name.nil?
      err_exit "Volume name must be specified through -n/--name"
    end
    
    url = '/volumes?name=' + vol_name
    begin
      debug_out "Delete #{@base_url}#{url}"
      @resource[url].delete
    rescue Exception => e
      debug_out e
      err_exit "Fail to remove volume #{vol_name}", 0
    else
      puts "Successfully remove volume #{vol_name}"
    end
  end
  
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_volume_remove
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end

end
