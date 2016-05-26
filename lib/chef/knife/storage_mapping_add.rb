require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageMappingAdd < Chef::Knife::StorageBase
  banner 'knife storage mapping add'
  
  common_options
  
  option :ig_name,
         :short => '-i NAME',
         :long  => '--ig NAME',
         :description => 'Initiator group name'
  
  option :lun_name,
         :short => '-l NAME',
         :long  => '--lun NAME',
         :description => 'LUN Name'
    
  def xio_mapping_add  
    ig_name = get_config('ig_name')
    lun_name = get_config('lun_name')
    debug_out "Initiator group name: #{ig_name}\nLUN name: #{lun_name}"
    if ig_name.nil? or lun_name.nil?
      err_exit "Initiator group name(-i/--ig) and LUN name(-l/--lun) must be specified"
    end

    begin
      data = "{\"ig-id\":\"#{ig_name}\",\"vol-id\":\"#{lun_name}\"}"

      debug_out "Post data #{data} to #{@base_url}/lun-maps"
      @resource['/lun-maps'].post data
    rescue Exception => e
      debug_out e
      err_exit "Internal error, try again!", 0
    else
      puts "Map between initiator group #{ig_name} and LUN #{lun_name} are successfully added"
    end
  end 
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_mapping_add
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end

end
