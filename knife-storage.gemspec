Gem::Specification.new do |s|
  s.name        = 'knife-storage'
  s.version     = '0.1.0'
  s.date        = '2016-05-17'
  s.summary     = "knife storage"
  s.description = "a EMC storage plugin for knife"
  s.authors     = ["KC Bi"]
  s.email       = 'kecheng.bi@emc.com'
  s.files       = [
                    "knife.rb.sample",
                    "LICENSE",
                    "README.md",
                    "lib/chef/knife/storage_base.rb",
                    "lib/chef/knife/storage_initiator_add.rb",
                    "lib/chef/knife/storage_initiator_group_add.rb",
                    "lib/chef/knife/storage_initiator_group_list.rb",
                    "lib/chef/knife/storage_initiator_group_remove.rb",
                    "lib/chef/knife/storage_initiator_group_rename.rb",
                    "lib/chef/knife/storage_initiator_group_show.rb",
                    "lib/chef/knife/storage_initiator_list.rb",
                    "lib/chef/knife/storage_initiator_remove.rb",
                    "lib/chef/knife/storage_initiator_show.rb",
                    "lib/chef/knife/storage_mapping_add.rb",
                    "lib/chef/knife/storage_mapping_list.rb",
                    "lib/chef/knife/storage_mapping_remove.rb",
                    "lib/chef/knife/storage_mapping_show.rb",
                    "lib/chef/knife/storage_target_list.rb",
                    "lib/chef/knife/storage_target_show.rb",
                    "lib/chef/knife/storage_volume_add.rb",
                    "lib/chef/knife/storage_volume_list.rb",
                    "lib/chef/knife/storage_volume_remove.rb",
                    "lib/chef/knife/storage_volume_show.rb",
                    "sanity_test.sh",
                  ]
  s.license       = 'Apache-2.0'
end
