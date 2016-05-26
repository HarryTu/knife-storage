require 'chef/knife'
require 'chef/knife/storage_base'
require 'thread'

class Chef::Knife::StorageMappingList < Chef::Knife::StorageBase
  banner 'knife storage mapping list'
  
  common_options
    
  def xio_mapping_list          
    begin
      debug_out "Get #{@base_url}/lun-maps"
      lun_maps = JSON.parse @resource['/lun-maps'].get
    rescue Exception => e
      debug_out e
      err_exit "Internal error, try again!", 0
    end

    map_ids = []
    lun_maps['lun-maps'].each do |map|
      map_ids << map['href'].match('\d+?$')[0]
    end
    
    threads = []
    lock = Mutex.new

    maps = {}
    map_ids.each do |id|
      threads << Thread.new {
        begin
          debug_out "Get #{@base_url}/lun-maps/#{id}"
          details = JSON.parse @resource["/lun-maps/#{id}"].get
        rescue Exception => e
          # Do not break execution even one data for a map can not be retrieved
          debug_out e
        else
          data = details['content']
        
          lock.synchronize {
            if maps["#{data['ig-name']}"].nil?
              maps["#{data['ig-name']}"] = []
            end
        
            #maps["#{data['ig-name']}"] << {"#{data['vol-name']}" => "#{data['vol-index']}"}
            maps["#{data['ig-name']}"] << "#{data['vol-name']} (map id:#{id})"
          }
        end
      }
    end
    
    threads.each { |thread| thread.join }
    
    maps.keys.each do |key|
      puts "Volumes under initiator group \"#{key}\":\n"
      maps[key].each do |vol|
        puts "  #{vol}"
      end
    end
  end
  
  def run
    login
    case @array_type
    when 'xtremio', 'xio'
      xio_mapping_list
    when 'vmax'
      nil
    when 'vnx'
      nil
    end          
  end
end
