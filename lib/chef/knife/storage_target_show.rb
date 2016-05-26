require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageTargetShow < Chef::Knife::StorageBase
  banner 'knife storage target show'
  
  common_options
  
  option :target_name,
         :short => '-n NAME',
         :long  => '--name NAME',
         :description => 'Target name'
    
  def xio_target_show
    target_name = get_config('target_name')
    debug_out "Target name: #{target_name}"
    if target_name.nil?
      err_exit "Target name must be specified through -n/--name"
    end
    url = '/targets/?name=' + target_name
              
    begin
      debug_out "Get #{@base_url}#{url}"
      data = JSON.parse @resource[url].get
    rescue Exception => e
      debug_out e
      err_exit "Internal error, try again!", 0
    end

    d = data['content']
    puts "Total cumulative read I/Os: #{d['acc-num-of-rd']}"
    puts "Accumulated number of small : #{d['acc-num-of-small-rd']}"
    puts "Accumulated number of small writes: #{d['acc-num-of-small-wr']}"
    puts "Accumulated number of unaligned reads: #{d['acc-num-ofunaligned-rd']}"
    puts "Accumulated number of unaligned writes: #{d['acc-num-ofunaligned-wr']}"
    puts "Initiator Group’s total cumulative write I/Os: #{d['acc-num-of-wr']}"
    puts "Total cumulative read size: #{d['acc-size-of-rd']}"
    puts "Total cumulative write size: #{d['acc-size-of-wr']}"
    puts "Total real-time latency: #{d['avg-latency']}"
    puts "X-Brick's index number: #{d['brick-id']}"
    puts "Total real-time bandwidth: #{d['bw']}"
    puts "XMS certainty: #{d['certainty']}"
    puts "Driver version: #{d['driver-version']}"
    puts "Kbytes received: #{d['eth-kbytes-rx']}"
    puts "Kbytes transmitted: #{d['eth-kbytes-tx']}"
    puts "Ethernet packets received: #{d['eth-pkt-rx']}"
    puts "Ethernet frames received with CRC errors: #{d['eth-pkt-rx-crc-error']}"
    puts "Packets failing to be received: #{d['eth-pkt-rx-no-buffer-error']}"
    puts "Ethernet packets transmitted: #{d['eth-pkt-tx']}"
    puts "Number of packets that failed to be transmitted: #{d['eth-pkt-tx-error']}"
    puts "Fibre Channel dumped frames: #{d['fc-dumped-frames']}"
    puts "Fibre Channel invalid CRC count: #{d['fc-invalid-crc-count']}"
    puts "Fibre Channel link failure count: #{d['fc-link-failure-count']}"
    puts "Fibre Channel loss of signal count: #{d['fc-loss-of-signal-count']}"
    puts "Fibre Channel loss of synchronized count: #{d['fc-loss-of-sync-count']}"
    puts "Fibre Channel primary sequential protocol error count: #{d['fc-prim-seq-prot-err-count']}"
    puts "Fibre-Chanel sequential retransmission request count: #{d['fc-seq-retx-req-count']}"
    puts "Firmware version: #{d['fw-version']}"
    puts "Index number: #{d['index']}"
    puts "Input/output per second: #{d['iops']}"
    puts "Jumbo enabled: #{d['jumbo-enabled']}"
    puts "Maximum transmission unit: #{d['mtu']}"
    puts "Name: #{d['name']}"
    puts "Storage Controller object index number: #{d['node-id']}"
    puts "Object severity: #{d['obj-severity']}"
    puts "Port address: #{d['port-address']}"
    puts "Portal list: #{d['portal-list']}"
    puts "Target health level: #{d['port-health-level']}"
    puts "Port index: #{d['port-index']}"
    puts "Port MAC address: #{d['port-mac-addr']}"
    puts "Port speed: #{d['port-speed']}"
    puts "Port state: #{d['port-state']}"
    puts "Port type: #{d['port-type']}"
    puts "Total real-time read bandwidth: #{d['rd-bw']}"
    puts "Read input/output per second: #{d['rd-iops']}"
    puts "Total real-time read latency: #{d['rd-latency']}"
    puts "Relative Target port: #{d['relative-target-port']}"
    puts "Small I/O bandwidth: #{d['small-bw']}"
    puts "Small input/output per second: #{d['small-iops']}"
    puts "Small read bandwidth: #{d['small-rd-bw']}"
    puts "Small read input/output per second: #{d['small-rd-iops']}"
    puts "Small write bandwidth: #{d['small-wr-bw']}"
    puts "Small write input/output per second: #{d['small-wr-iops']}"
    puts "Cluster’s index number: #{d['sys-id']}"
    puts "Tag list: #{d['tag-list']}"
    puts "Target error reason: #{d['tar-error-reason']}"
    puts "Target’s name or the index number: #{d['tar-id']}"
    puts "Target Group object index number: #{d['tg-id']}"
    puts "Unaligned I/O bandwidth: #{d['unaligned-bw']}"
    puts "Unaligned input/output per second: #{d['unaligned-iops']}"
    puts "Unaligned read bandwidth: #{d['unaligned-rd-bw']}"
    puts "Unaligned read input/output per second: #{d['unaligned-rd-iops']}"
    puts "Unaligned write bandwidth: #{d['unaligned-wr-bw']}"
    puts "Unaligned write input/output per second: #{d['unaligned-wr-iops']}"
    puts "Write bandwidth: #{d['wr-bw']}"
    puts "Total real-time write input/output per second: #{d['wr-iops']}"
    puts "Target’s total real-time write latency: #{d['wr-latency']}"
    puts "XtremIO Management Server index number: #{d['xms-id']}"
  end
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_target_show
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end

end
