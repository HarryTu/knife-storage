require 'chef/knife'
require 'rest-client'
require 'json'

class Chef
  class Knife
    class StorageBase < Knife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
    
      def self.common_options
        option :array_user,
               :short => '-u USERNAME',
               :long => '--user USERNAME',
               :description => 'The user name for the storage array'
        
        option :array_pass,
               :short => '-p PASSWORD',
               :long => '--password PASSWORD',
               :description => 'The password for the storage array'
        
        option :array_host,
               :short => '-h HOST',
               :long => '--host HOST',
               :description => 'Storage Array Hostname or IP Address'
        
        option :array_type,
               :short => '-t TYPE',
               :long => '--type TYPE',
               :description => 'Storage array type: XtremIO/VMAX/VNX/etc.'     
      end
    
      def get_config(key)
        key = key.to_sym
        value = config[key] || Chef::Config[:knife][key]
      end

      def err_exit(mesg, flag=1)
        puts "\n"
        Chef::Log.error(mesg)
        puts "\n"

        if flag == 1
          show_usage
        end
        
        exit 1
      end

      def debug_out(mesg)
        Chef::Log.debug(mesg) 
      end

      def login
        type = get_config('array_type')
        if type.nil?
          err_exit "Storage array type must be specified by -t/--type"
        else
          @array_type = type.downcase
        end
        
        case @array_type
        when 'xtremio', 'xio'
          @base_url = 'https://' + get_config('array_host') + '/api/json/v2/types'

          begin
            @resource = RestClient::Resource.new(
              @base_url,
              :user => get_config('array_user'),
              :password => get_config('array_pass'),
              :ssl_client_key => OpenSSL::PKey::RSA.new(File.read(get_config('client_key')),
                get_config('client_key_pass')),
              :ssl_client_cert => OpenSSL::X509::Certificate.new(File.read(get_config('client_cert'))),
              verify_ssl: OpenSSL::SSL::VERIFY_NONE)
          rescue Exception => e
            debug_out "Cannot initialize Restclient::Resource #{e}"
            err_exit "Internal error, try again!", 0
          end
        when 'vmax'
          # TBD
        when 'vnx'
          # TBD
        else
          err_exit "Storage array type \"#{@array_type}\" is not supported"
        end
        
      end
    end    
  end
end
