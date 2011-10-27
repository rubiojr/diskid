# Disk Identification Service 
 
## Installation

    gem install diskid

diskid needs curl and head commands available in your system.

Internet access is also required, as diskid sends a few bytes to http://diskid.frameos.org to identify the disk.

## Usage

    diskid path-to-disk-file
    
i.e.

    diskid my-vm-disk.vmdk


Copyright (c) 2011 Sergio Rubio. See LICENSE.txt for
further details.

