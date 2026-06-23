oci setup config

oci compute instance list --compartment-id compartment-ocid

oci compute instance get --instance-id instance-ocid

oci compute instance launch --compartment-id compartment-ocid --availability-domain availability-domain --shape VM.Standard.E4.Flex --subnet-id subnet-ocid

oci bv volume list --compartment-id compartment-ocid

oci network vcn list --compartment-id compartment-ocid

oci network subnet list --compartment-id compartment-ocid

oci network load-balancer list --compartment-id compartment-ocid

oci os bucket list --compartment-id compartment-ocid

oci iam user list --compartment-id tenancy-ocid

oci db system list --compartment-id compartment-ocid

oci dns zone list --compartment-id compartment-ocid
