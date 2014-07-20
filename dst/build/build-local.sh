#!/usr/bin/env bash

DST_DSATCL_VERSION="0.0.2"

rm -rf output-virtualbox-iso
rm -rf packer_virtualbox-iso_virtualbox.box

echo "Build Vagrant with Packer"
packer build -var-file=variables.json -var "dst_dsatcl_version=${DST_DSATCL_VERSION}" -only=virtualbox-iso dst-dsatcl.json 

echo "Rename Vagrant box"
mv packer_virtualbox-iso_virtualbox.box boxes/$DST_DSATCL_BOX

echo "Update local Vagrant box"
vagrant box remove dst-dsatcl
vagrant box add dst-dsatcl boxes/$DST_DSATCL_BOX
