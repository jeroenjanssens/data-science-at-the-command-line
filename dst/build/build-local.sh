#!/usr/bin/env bash

DST_DSATCL_VERSION="0.0.5"
DST_DSATCL_BOX="dst-dsatcl-${DST_DSATCL_VERSION}.box"
DST_DSATCL_URL="https://data-science-toolbox.s3.amazonaws.com/${DST_DSATCL_BOX}"

#echo "Build Vagrant with Packer"
#rm -rf output-virtualbox-iso
#rm -rf packer_virtualbox-iso_virtualbox.box
#packer build -var-file=variables.json -var "dst_dsatcl_version=${DST_DSATCL_VERSION}" -only=virtualbox-iso dst-dsatcl.json && mv packer_virtualbox-iso_virtualbox.box boxes/$DST_DSATCL_BOX

#echo "Update local Vagrant box"
#vagrant box remove dst-dsatcl
#vagrant box add dst-dsatcl boxes/$DST_DSATCL_BOX

echo $DST_DSATCL_URL

#echo "Upload to S3"
#aws s3 cp boxes/$DST_DSATCL_BOX s3://data-science-toolbox/$DST_DSATCL_BOX --acl public-read
