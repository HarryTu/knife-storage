require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageInitiatorRemove < Chef::Knife::StorageBase
  banner 'knife storage initiator remove'
  
  common_options
  
  #option :initiator_id,
  #       :short => '-i ID',
  #       :long  => '--id ID',
  #       :description => 'The initiator ID'
  
  option :initiator_name,
         :short => '-n NAME',
         :long  => '--name NAME',
         :description => 'The initiator name'

  def xio_initiator_remove            
    #initiator_id = get_config('initiator_id')
    initiator_name = get_config('initiator_name')
    debug_out "Initiator name: #{initiator_name}"
    if initiator_name.nil?
      err_exit "Initiator name must be specified through -n/--name"
    end
    
    url = '/initiators/?name=' + initiator_name
    
    begin
      debug_out "Delete #{@base_url}#{url}"
      @resource[url].delete
    rescue Exception => e
      debug_out e
      err_exit "Internal error, try again!", 0
    else
      puts "Initiator #{initiator_name} is successfully deleted"
    end
  end
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_initiator_remove
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end

end
