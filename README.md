# Disk Identification Service 
 
## Installation

    gem install diskid

diskid needs curl and head commands available in your system.

Internet access is also required, as diskid sends a few bytes to http://diskid.frameos.org to identify the disk.

## Usage

    diskid path-to-disk-file
    
i.e.

    diskid my-vm-disk.vmdk

PROTIP: You don't need to install diskid to use the service

    head -n 20 ubuntu64-1104.vmdk > /tmp/dchunk && curl -X POST -F chunk=@/tmp/dchunk http://diskid.frameos.org

    

Copyright (c) 2011 Sergio Rubio. See LICENSE.txt for
further details.

