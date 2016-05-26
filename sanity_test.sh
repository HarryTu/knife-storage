#!/usr/bin/bash

# Volume test
knife storage volume list
knife storage volume add -n knife_testvol1 -s 100m
knife storage volume show -n knife_testvol1
knife storage volume remove -n knife_testvol1

# Initiator group test
knife storage initiator group list
knife storage initiator group add -g knife_ig1
knife storage initiator group show -g knife_ig1
knife storage initiator group rename -g knife_ig1 -n knife_ig2
knife storage initiator group remove -g knife_ig2

# Initiator test
knife storage initiator list
knife storage initiator group add -g knife_ig1
knife storage initiator add -g knife_ig1 -n knife_fake_iniiator1 -a '50:01:43:80:24:21:df:ab'
knife storage initiator show -n knife_fake_iniiator1
knife storage initiator remove -n knife_fake_iniiator1
knife storage initiator group remove -g knife_ig1

# Target test
knife storage target list
knife storage target show -n X1-SC1-fc1

# LUN mapping test
knife storage initiator group add -g knife_ig1
knife storage initiator add -g knife_ig1 -n knife_fake_iniiator1 -a '50:01:43:80:24:21:df:ab'
knife storage volume add -n knife_testvol1 -s 100m
knife storage mapping list
knife storage mapping add -i knife_ig1 -l knife_testvol1
ID=`knife storage mapping list | grep knife_testvol1 | cut -d':' -f2 | sed -e 's/)//'`
knife storage mapping show -i $ID
knife storage mapping remove -i $ID
knife storage volume remove -n knife_testvol1
knife storage initiator remove -n knife_fake_iniiator1
knife storage initiator group remove -g knife_ig1
