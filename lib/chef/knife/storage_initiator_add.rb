require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageInitiatorAdd < Chef::Knife::StorageBase
  banner 'knife storage initiator add'
  
  common_options
  
  option :initiator_group_name,
         :short => '-g NAME',
         :long  => '--group NAME',
         :description => 'The initiator group name'
  
  option :initiator_name,
         :short => '-n NAME',
         :long  => '--name NAME',
         :description => 'The initiator name'
  
  option :port_address,
         :short => '-a ADDRESS',
         :long  => '--address ADDRESS',
         :description => 'Initiator port address, such as FC WWPN, iSCSI IQN'
     
  def xio_initiator_add            
    initiator_group_name = get_config('initiator_group_name')
    initiator_name = get_config('initiator_name')
    port_address = get_config('port_address')

    debug_out("Initiator group name: #{initiator_group_name}\n" +
              "Initiator name: #{initiator_name}\n" +
              "Port address: #{port_address}")

    if initiator_group_name.nil? or initiator_name.nil? or port_address.nil?
      err_exit("Initiator group name(-g/--group), " +
              "initiator(-n/--name), " +
              "port address(-a/--address) must be specified")
    end
    
    data = "{\"ig-id\":\"#{initiator_group_name}\"," +
           "\"initiator-name\":\"#{initiator_name}\"," + 
           "\"port-address\":\"#{port_address}\"}"
    begin
      debug_out "Post data #{data} to #{@base_url}/initiators/"
      @resource['/initiators/'].post data
    rescue Exception => e
      debug_out e
      err_exit "Fail to add initiator #{initiator_name}"
    else
      puts "Add initiator #{initiator_name} successfully"
    end
  end
  
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_initiator_add
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end

end
