# knife-storage
Storage plugin for knife

1. In order to contact REST API through https, client key and certification need to be generated as below:
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem

2. In order to avoid typing paramters for a array box each time, options can be specified through knife configuration file. We provide a knife.rb.sample for your reference.

Known Problems:
1. XtremIO implements a different LUN mapping mechanism, which is volume based. Because of this, it is not able to get an overview of all existing LUN maps for an initiator group through one API call. To work around the problem, all existing mappings will be checked, and this costs quite some time.
