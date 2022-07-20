#/bin/sh

apt-get install qemu qemu-utils uuid-runtime curl kpartx git jq
pip -v >/dev/null || {apt-get install python3-pip}
pip3 install virtualenv
virtualenv -p /usr/bin/python3 /opt/octavia-image-build || exit 1
source /opt/octavia-image-build/bin/activate

pushd /tmp
git clone https://opendev.org/openstack/octavia.git
/opt/octavia-image-build/bin/pip install --isolated \
 git+https://git.openstack.org/openstack/diskimage-builder.git

pushd octavia/diskimage-create
./diskimage-create.sh
mv amphora-x64-haproxy.qcow2 /tmp
deactivate

popd
popd

# upload image
openstack image delete amphora-x64-haproxy
openstack image create --disk-format qcow2 \
  --container-format bare --tag octavia-amphora-image --file /tmp/amphora-x64-haproxy.qcow2 \
  --private --project service amphora-x64-haproxy
