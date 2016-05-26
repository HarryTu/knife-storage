require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageMappingShow < Chef::Knife::StorageBase
  banner 'knife storage mapping show'
  
  common_options
  
  option :map_id,
         :short => '-i ID',
         :long  => '--id ID',
         :description => 'LUN mapping ID'
  
  def xio_mapping_show  
    map_id = get_config('map_id')
    debug_out "Map ID: #{map_id}"
    if map_id.nil?
      err_exit "Lun mapping ID must be specified through -i/--id"
    end
    
    begin
      debug_out "Get #{@base_url}/lun-maps/#{map_id}"
      data = JSON.parse @resource["/lun-maps/#{map_id}"].get
    rescue Exception => e
      debug_out e
      err_exit "Internal error, try again!", 0
    end

    d = data['content']
    puts "XMS certainty: #{d['certainty']}"
    puts "Initiator Group index number: #{d['ig-index']}"
    puts "Initiator Group name: #{d['ig-name']}"
    puts "Index: #{d['index']}"
    puts "Unique LUN identification: #{d['lun']}"
    puts "Mapping index number: #{d['mapping-id']}"
    puts "Mapping index number: #{d['mapping-index']}"
    puts "Name: #{d['name']}"
    puts "Object severity: #{d['obj-severity']}"
    puts "Cluster’s name or index number: #{d['sys-id']}"
    puts "Target Group index number: #{d['tg-index']}"
    puts "Target’s group name: #{d['tg-name']}"
    puts "Volume index number: #{d['vol-index']}"
    puts "Volume name: #{d['vol-name']}"
    puts "XtremIO Management Server index number: #{d['xms-id']}"
  end
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_mapping_show
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end

end
