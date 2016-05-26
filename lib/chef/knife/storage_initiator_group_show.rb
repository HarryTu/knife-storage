require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageInitiatorGroupShow < Chef::Knife::StorageBase
  banner 'knife storage initiator group show'
  
  common_options
  
  option :group_name,
         :short => '-g NAME',
         :long  => '--group NAME',
         :description => 'Initiator group name'
      
  def xio_initiator_group_show                
    group_name = get_config('group_name')
    debug_out "Group name: #{group_name}"
    if group_name.nil?
      err_exit "Initiator group name must be specified through -g/--group"
    end
    url = '/initiator-groups?name=' + group_name
    
    begin    
      debug_out "Get #{@base_url}#{url}"
      data = JSON.parse @resource[url].get
    rescue Exception => e
      debug_out e
      err_exit 'Internal error, try again!'
    end

    d = data['content']
    puts "Total cumulative read I/Os: #{d['acc-num-of-rd']}"
    puts "Accumulated number of small reads: #{d['acc-num-of-small-rd']}"
    puts "Accumulated number of small writes: #{d['acc-num-of-small-wr']}"
    puts "Accumulated number of unaligned reads: #{d['acc-num-ofunaligned-rd']}"
    puts "Accumulated number of unaligned writes: #{d['acc-num-ofunaligned-wr']}"
    puts "Total cumulative write I/Os: #{d['acc-num-of-wr']}"
    puts "Total cumulative read size: #{d['acc-size-of-rd']}"
    puts "Total cumulative write size: #{d['acc-size-of-wr']}"
    puts "Total real-time bandwidth: #{d['bw']}"
    puts "XMS certainty: #{d['certainty']}"
    puts "Initiator Group object index number: #{d['ig-id']}"
    puts "Index number: #{d['index']}"
    puts "Input/output per second: #{d['iops']}"
    puts "Name: #{d['name']}"
    puts "Number of Initiators: #{d['num-of-initiators']}"
    puts "Cluster’s total provisioned Volumes: #{d['num-of-vols']}"
    puts "Object severity: #{d['obj-severity']}"
    puts "Total real-time read bandwidth: #{d['rd-bw']}"
    puts "Read input/output per second: #{d['rd-iops']}"
    puts "Small I/O bandwidth: #{d['small-bw']}"
    puts "Small input/output per : #{d['small-iops']}"
    puts "Small read bandwidth: #{d['small-rd-bw']}"
    puts "Small read input/output per second: #{d['small-rd-iops']}"
    puts "Small write bandwidth: #{d['small-wr-bw']}"
    puts "Small write input/output per second: #{d['small-wr-iops']}"
    puts "Cluster’s index number: #{d['sys-id']}"
    puts "Tag list: #{d['tag-list']}"
    puts "Unaligned I/O bandwidth: #{d['unaligned-bw']}"
    puts "Unaligned input/output per second: #{d['unaligned-iops']}"
    puts "Unaligned read bandwidth: #{d['unaligned-rd-bw']}"
    puts "Unaligned read Input/output per second: #{d['unaligned-rd-iops']}"
    puts "Unaligned write bandwidth: #{d['unaligned-wr-bw']}"
    puts "Unaligned write input/output per second: #{d['unaligned-wr-iops']}"
    puts "Write bandwidth: #{d['wr-bw']}"
    puts "Total real-time write input/output per second: #{d['wr-iops']}"
    puts "XtremIO Management Server index number: #{d['xms-id']}"
  end
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_initiator_group_show
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end
end
