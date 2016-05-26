# knife-storage

# DESCRIPTION

A plugin to enable storage provisioning/management from Chef knife CLI

# INSTALLATION

    gem install knife storage

# CONFIGURATION

For some arrays, commands are implemented through their REST API, which involes https communications. This requires the existence of a client key, a client certificaiton and a passphase. They can be generated as below:

    openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem

After generating required key/certification/passphase, they should be configured in your knife.rb as below:

    current_dir = File.dirname(__FILE__)
    knife[:client_key] = "#{current_dir}/xio_key.pem"
    knife[:client_cert] = "#{current_dir}/xio_cert.pem"
    knife[:client_key_pass] = 'Y0urpassword!'

Several other parameters, which can be specified throug either CLI options or knife.rb configuration, are also required to run the plugin. 

CLI Options:

    --array-host HOST            Storage Array Hostname or IP Address
    --array-user USERNAME        The user name for the storage array
    --array-pass PASSWORD        The password for the storage array
    --array-type TYPE            Storage array type: XtremIO/VMAX/VNX/etc.

knife.rb:

    knife[:array_host] = '192.168.1.1'
    knife[:array_user] = 'admin'
    knife[:array_pass] = 'Credent1al!'
    knife[:array_type] = 'XtremIO'

# USAGE INSTRUCTION

Below are current available commands:

    knife storage initiator group add
    knife storage initiator group list
    knife storage initiator group remove
    knife storage initiator group rename
    knife storage initiator group show
    knife storage initiator add
    knife storage initiator list
    knife storage initiator remove
    knife storage initiator show
    knife storage mapping add
    knife storage mapping list
    knife storage mapping remove
    knife storage mapping show
    knife storage target list
    knife storage target show
    knife storage volume add
    knife storage volume list
    knife storage volume remove
    knife storage volume show

# FUTURE

Only XtremIO is supported for now. Support for other arrays, such as Unity, VMAX,  will be added later.

# TEST

    ./sanity_test.sh

# CONTRIBUTION 

Create a fork of the project into your own reposity. Make all your necessary changes and create a pull request with a description on what was added or removed and details explaining the changes in lines of code. If approved, project owners will merge it.

# LICENSE

The project is licensed under the MIT License - refer to [LICENSE](LICENSE) for details.

# KNOWN PROBLEM:

* XtremIO implements a different LUN mapping mechanism, which is volume based. Because of this, it is not able to get an overview of all existing LUN maps for an initiator group through one API call. To work around the problem, all existing mappings will be checked, and this costs quite some time.
