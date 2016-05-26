require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageMappingRemove < Chef::Knife::StorageBase
  banner 'knife storage mapping remove'
  
  common_options
  
  option :mapping_id,
         :short => '-i ID',
         :long  => '--id ID',
         :description => 'LUN Mapping ID'
    
  def xio_mapping_remove  
    map_id = get_config('mapping_id')
    debug_out "Mapping id #{map_id}"
    if map_id.nil?
      err_exit "Map id must be specified through -i/--id"
    end
    
    begin
      debug_out "Delete #{@base_url}/lun-maps/#{map_id}"
      @resource['/lun-maps/' + map_id].delete
    rescue Exception => e
      err_exit e
      debug_out "Internal error, try again!", 0
    else
      puts "Map with ID #{map_id} is successfully deleted"
    end
  end 
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_mapping_remove
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end

end
