require 'chef/knife'
require 'chef/knife/unity/unity_storage_test'


class Chef::Knife::UnityStorageTest < Chef::Knife::unity::StorageBase
  banner 'knife storage initiator group add'
end