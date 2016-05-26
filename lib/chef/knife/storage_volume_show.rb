require 'chef/knife'
require 'chef/knife/storage_base'

class Chef::Knife::StorageVolumeShow < Chef::Knife::StorageBase
  banner 'knife storage volume show'
  
  common_options
  
  option :vol_name,
         :short => '-n NAME',
         :long => '--name NAME',
         :description => 'The volume name'
  
  #option :vol_id,
  #       :short => '-i ID',
  #       :long => '--id ID',
  #       :description => 'The volume ID'
   
  def xio_volume_show
    vol_name = get_config('vol_name')
    #vol_id = get_config('vod_id')
    debug_out "Volume name: #{vol_name}"
    
    if vol_name.nil?
      err_exit "Volume name must be specified through -n/--name"
    end

    url = '/volumes?name=' + vol_name
    
    begin
      debug_out "Get #{@base_url}#{url}"
      data = JSON.parse @resource[url].get
    rescue Exception => e
      debug_out e
      err_exit "Internal error, try again!", 0
    end

    d = data['content']
    puts "Total cumulative read I/Os: #{d['acc-num-of-rd']}"
    puts "Accumulated number of small reads: #{d['acc-num-of-small-rd']}"
    puts "Accumulated number of small writes: #{d['acc-num-of-small-wr']}"
    puts "Accumulated number of unaligned reads: #{d['acc-num-of-unaligned-rd']}"
    puts "Accumulated number of unaligned writes: #{d['acc-num-of-unaligned-wr']}"
    puts "Total cumulative write I/Os: #{d['acc-num-of-wr']}"
    puts "Total cumulative read size: #{d['acc-size-of-rd']}"
    puts "Total cumulative write size #{d['acc-size-of-wr']}"
    puts "Alignment offset: #{d['alignment-offset']}"
    puts "Ancestor Volume object index number: #{d['ancestor-vol-id']}"
    puts "Total real-time latency: #{d['avg-latency']}"
    puts "Total real-time bandwidth: #{d['bw']}"
    puts "XMS certainty: #{d['certainty']}"
    puts "Created from Volume: #{d['created-from-volume']}"
    puts "Creation time: #{d['creation-time']}"
    puts "Destination Snapshot list: #{d['dest-snap-list']}"
    puts "Index number: #{d['index']}"
    puts "Input/output per second: #{d['iops']}"
    puts "Logical block size in bytes: #{d['lb-size']}"
    puts "Logical space in use: #{d['logical-space-in-use']}"
    puts "LUN mapping list: #{d['lun-mapping-list']}"
    puts "NAA name: #{d['naa-name']}"
    puts "Name: #{d['name']}"
    puts "Number of destination Snapshots: #{d['num-of-dest-snaps']}"
    puts "Number of LUN mappings: #{d['num-of-lun-mappings']}"
    puts "Object severity: #{d['obj-severity']}"
    puts "Total real-time read bandwidth: #{d['rd-bw']}"
    puts "Read input/output per second: #{d['rd-iops']}"
    puts "Total real-time read latency: #{d['rd-latency']}"
    puts "Related Consistency Groups: #{d['related-consistency-groups']}"
    puts "Small I/O bandwidth: #{d['small-bw']}"
    puts "Small input/output Alerts: #{d['small-io-alerts']}"
    puts "Small input/output per second: #{d['small-iops']}"
    puts "Small input/output ratio level: #{d['small-io-ratio']}"
    puts "Small input/output ratio level: #{d['small-io-ratio-level']}"
    puts "Small read bandwidth: #{d['small-rd-bw']}"
    puts "Small read input/output per second: #{d['small-rd-iops']}"
    puts "Small write bandwidth: #{d['small-wr-bw']}"
    puts "Small write input/output per second: #{d['small-wr-iops']}"
    puts "Snapshot group object index number: #{d['snapgrp-id']}"
    puts "Snapshot Set list: #{d['snapset-list']}"
    puts "Snapshot type: #{d['snapshot-type']}"
    puts "Cluster’s index number: #{d['sys-id']}"
    puts "Tag list: #{d['tag-list']}"
    puts "Unaligned I/O bandwidth: #{d['unaligned-bw']}"
    puts "Unaligned input/output Alerts: #{d['unaligned-io-alerts']}"
    puts "Unaligned input/output per second: #{d['unaligned-iops']}"
    puts "Unaligned input/output ratio: #{d['unaligned-io-ratio']}"
    puts "Unaligned input/output ratio level: #{d['unaligned-io-ratio-level']}"
    puts "Unaligned read bandwidth: #{d['unaligned-rd-bw']}"
    puts "Unaligned read input/output per second: #{d['unaligned-rd-iops']}"
    puts "Unaligned write bandwidth: #{d['unaligned-wr-bw']}"
    puts "Unaligned write input/output per second: #{d['unaligned-wr-iops']}"
    puts "VAAI TP limit: #{d['vaai-tp-alerts']}"
    puts "Volume access: #{d['vol-access']}"
    puts "Index: #{d['vol-id']}"
    puts "Total provisioned capacity: #{d['vol-size']}"
    puts "Volume type: #{d['vol-type']}"
    puts "Write bandwidth: #{d['wr-bw']}"
    puts "Total real-time write input/output per second: #{d['wr-iops']}"
    puts "Total real-time write latency: #{d['wr-latency']}"
    puts "XtremIO Management Server index number: #{d['xms-id']}"
  end
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_volume_show
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end

end
