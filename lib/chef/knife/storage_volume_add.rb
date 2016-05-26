require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageVolumeAdd < Chef::Knife::StorageBase
  banner 'knife storage volume add'
  
  common_options
  
  option :vol_name,
         :short => '-n NAME',
         :long => '--name NAME',
         :description => 'The volume name'
  
  option :vol_size,
         :short => '-s SIZE',
         :long => '--size SIZE',
         :description => 'Volume size in K/M/G/T/P'
   
  def xio_volume_add
    vol_name = get_config('vol_name')
    vol_size = get_config('vol_size')
    debug_out "Volume name: #{vol_name}\nVolume size: #{vol_size}"
    
    if vol_name.nil? or vol_size.nil?
      err_exit "Both volume name(-n/--name) and volume size(-s/--size) should be specified"
    end
    
    data = "{\"vol-name\":\"#{vol_name}\",\"vol-size\":\"#{vol_size}\"}"
    
    begin
      debug_out "Post data #{data} to #{@base_url}/volumes/"
      ret = JSON.parse @resource['/volumes/'].post data
    rescue Exception => e
      debug_out e
      err_exit "Internal error, try again!", 0
    end

    unless ret['links'].empty?
      puts "Volume #{vol_name} is successfully created"
    else
      err_exit "Fail to create volume #{vol_name}"
    end
  end
  
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_volume_add
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end

end
