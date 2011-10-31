# DiskID
 
Get info from a virtual disk file.

    $ diskid micro-frameos.vmdk

    diskid.frameos.org

    file name: micro-frameos.vmdk
    file format: vmdk
    virtual size: 1.2G (1287651328 bytes)
    disk size: 274M (287593984 bytes)

## Installation

    gem install diskid

diskid needs curl and head commands available in your system.

Internet access is also required, as diskid sends a few bytes to http://diskid.frameos.org to identify the disk.

## Usage

    diskid --help
    
### EXAMPLES

Identify a VMDK:

    $ diskid ubuntu64-1104.vmdk

    diskid.frameos.org

    file name: ubuntu64-1104.vmdk
    file format: vmdk
    virtual size: 9.0G 
    variant: streamOptimized
    disk size: 319M 


PROTIP: You don't need to install diskid to use the service

    head -n 20 ubuntu64-1104.vmdk > /tmp/dchunk && curl -X POST -F chunk=@/tmp/dchunk http://diskid.frameos.org/?format=text

Identify a VMDK and print JSON output:
    
    $ diskid --format json ubuntu64-1104.vmdk

    diskid.frameos.org

    {"file_name":"ubuntu64-1104.vmdk","format":"vmdk", "variant":"streamOptimized", "virtual_size":"9.0G","disk_size":"319M"}

  Valid output formats:

  * json
  * text
  * xml

Identify a virtual disk without using the diskid.frameos.org web service (needs qemu-img installed locally):

    $ diskid --local ubuntu64-1104.vmdk
    file_name: ubuntu64-1104.vmdk
    format: vmdk
    variant: monolithicSparse
    virtual_size: 9.0G
    disk_size: 319M


## NERD STUFF

DiskID Webservice is a thin wrapper around the bleeding edge version of qemu-img from the QEMU project: http://qemu.org

All the magic happens there!

Copyright (c) 2011 Sergio Rubio. See LICENSE.txt for
further details.

