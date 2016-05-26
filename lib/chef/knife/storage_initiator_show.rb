require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageInitiatorShow < Chef::Knife::StorageBase
  banner 'knife storage initiator show'
  
  common_options
  
  #option :initiator_id,
  #       :short => '-i ID',
  #       :long  => '--id ID',
  #       :description => 'The initiator ID'
  
  option :initiator_name,
         :short => '-n NAME',
         :long  => '--name NAME',
         :description => 'The initiator name'
    
  def xio_initiator_show            
    initiator_name = get_config('initiator_name')
    debug_out "Initiator name: #{initiator_name}"
    if initiator_name.nil? 
      err_exit "Initiator name much be specified through -n/--name"
    end
    
    url = '/initiators/?name=' + initiator_name
    
    begin
      debug_out "Get #{@base_url}#{url}"
      data = JSON.parse @resource[url].get
    rescue Exception => e
      debug_out e
      err_exit "Internal error, try again!", 0
    end

    d = data['content']
    puts "Accumulative number of reads: #{d['acc-num-of-rd']}"
    puts "Accumulated number of small reads: #{d['acc-num-of-small-rd']}"
    puts "Accumulated number of small writes: #{d['acc-num-of-small-wr']}"
    puts "Accumulated number of unaligned reads: #{d['acc-num-of-unaligned-rd']}"
    puts "Accumulated number of unaligned writes: #{d['acc-num-ofunaligned-wr']}"
    puts "Total cumulative write I/Os: #{d['acc-num-of-wr']}"
    puts "Total cumulative read size: #{d['acc-size-of-rd']}"
    puts "Total cumulative write size: #{d['acc-size-of-wr']}"
    puts "Total real-time latency: #{d['avg-latency']}"
    puts "Total real-time bandwidth: #{d['bw']}"
    puts "XMS certainty: #{d['certainty']}"
    puts "CHAP authentication cluster password: #{d['chap-authenticationcluster-password']}"
    puts "CHAP authentication cluster username: #{d['chap-authenticationcluster-user-name']}"
    puts "CHAP authentication Initiator password: #{d['chap-authenticationinitiator-password']}"
    puts "CHAP authentication Initiator username: #{d['chap-authenticationinitiator-user-name']}"
    puts "CHAP discovery cluster password: #{d['chap-discoverycluster-password']}"
    puts "CHAP discovery cluster username: #{d['chap-discoverycluster-user-name']}"
    puts "CHAP discovery Initiator password: #{d['chap-discoveryinitiator-password']}"
    puts "CHAP discovery Initiator user: #{d['chap-discoveryinitiator-user-name']}"
    puts "Initiator Group object index number: #{d['ig-id']}"
    puts "Index number: #{d['index']}"
    puts "Initiator connection state: #{d['initiator-conn-state']}"
    puts "Initiator object index number: #{d['initiator-id']}"
    puts "Input/output per second: #{d['iops']}"
    puts "Name: #{d['name']}"
    puts "Number of connected Targets: #{d['num-of-conn-tars']}"
    puts "Object severity: #{d['obj-severity']}"
    puts "Operating system: #{d['operating-system']}"
    puts "Port address: #{d['port-address']}"
    puts "Port type: #{d['port-type']}"
    puts "Total real-time read bandwidth: #{d['rd-bw']}"
    puts "Read input/output per second: #{d['rd-iops']}"
    puts "Total real-time read latency: #{d['rd-latency']}"
    puts "Small I/O bandwidth: #{d['small-bw']}"
    puts "Small input/output per second: #{d['small-iops']}"
    puts "Small read bandwidth: #{d['small-rd-bw']}"
    puts "Small read input/output per second: #{d['small-rd-iops']}"
    puts "Small write bandwidth: #{d['small-wr-bw']}"
    puts "Small write input/output per second: #{d['small-wr-iops']}"
    puts "Cluster’s name or index number: #{d['sys-id']}"
    puts "Tag list: #{d['tag-list']}"
    puts "Unaligned I/O bandwidth: #{d['unaligned-bw']}"
    puts "Unaligned input/output per second: #{d['unaligned-iops']}"
    puts "Unaligned read bandwidth: #{d['unaligned-rd-bw']}"
    puts "Unaligned read input/output per second: #{d['unaligned-rd-iops']}"
    puts "Unaligned write bandwidth: #{d['unaligned-wr-bw']}"
    puts "Unaligned write input/output per second: #{d['unaligned-wr-iops']}"
    puts "Write bandwidth: #{d['wr-bw']}"
    puts "Total real-time write input/output per second: #{d['wr-iops']}"
    puts "Initiator’s total real-time write latency: #{d['wr-latency']}"
    puts "XtremIO Management Server index number: #{d['xms-id']}"
  end
  
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_initiator_show
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end

end
