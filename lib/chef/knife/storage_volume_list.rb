require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageVolumeList < Chef::Knife::StorageBase
  banner 'knife storage volume list'
  
  common_options
  
  def xio_vloume_list
    begin
      debug_out "Get #{@base_url}/volumes"
      data = JSON.parse @resource['/volumes'].get
    rescue Exception => e
      err_exit "Internal error, try again!", 0
    end
    
    data['volumes'].each do |volume|
      vol_name = volume['name']
      #vol_id = /\/(\d+?)$/.match(volume['href'])[1]
      #debug_out("Find volume #{vol_name} with ID #{vol_id}")
      
      #puts "Volume: #{vol_name}, Volume ID: #{vol_id}"
      puts "#{vol_name}"
    end    
  end
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_vloume_list
    when 'vmax'
      nil
    when 'vnx'
      nil
    else
      show_usage
    end
  end

end
