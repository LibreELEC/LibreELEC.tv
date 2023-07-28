PKG_NAME="tuf"
PKG_VERSION="0.12.2"
PKG_LICENSE="MIT"
PKG_SITE="https://theupdateframework.io/"
PKG_DEPENDS_TARGET="toolchain crossenv:host"
PKG_DEPENDS_TARGET="toolchain crossenv:host tuf:host Python3"
PKG_TOOLCHAIN="manual"

unpack() {
  sources=$(cat << EOF
https://files.pythonhosted.org/packages/05/54/3324b0c46340c31b909fcec598696aaec7ddc8c18a63f2db352562d3354c/cffi-1.14.0.tar.gz
https://files.pythonhosted.org/packages/ae/e7/d9c3a176ca4b02024debf82342dab36efadfc5776f9c8db077e8f6e71821/pycparser-2.20-py2.py3-none-any.whl
https://files.pythonhosted.org/packages/b9/63/df50cac98ea0d5b006c55a399c3bf1db9da7b5a24de7890bc9cfd5dd9e99/certifi-2019.11.28-py2.py3-none-any.whl
https://files.pythonhosted.org/packages/bc/a9/01ffebfb562e4274b6487b4bb1ddec7ca55ec7510b22e4c51f14098443b8/chardet-3.0.4-py2.py3-none-any.whl
https://files.pythonhosted.org/packages/be/60/da377e1bed002716fb2d5d1d1cab720f298cb33ecff7bf7adea72788e4e4/cryptography-2.8.tar.gz
https://files.pythonhosted.org/packages/89/e3/afebe61c546d18fb1709a61bee788254b40e736cff7271c7de5de2dc4128/idna-2.9-py2.py3-none-any.whl
https://files.pythonhosted.org/packages/ef/57/7162609dab394d38bbc7077b7ba0a6f10fb09d8b7701ea56fa1edc0c4345/iso8601-0.1.12-py2.py3-none-any.whl
https://files.pythonhosted.org/packages/d4/70/d60450c3dd48ef87586924207ae8907090de0b306af2bce5d134d78615cb/python_dateutil-2.8.1-py2.py3-none-any.whl
https://files.pythonhosted.org/packages/1a/70/1935c770cb3be6e3a8b78ced23d7e0f3b187f5cbfab4749523ed65d7c9b1/requests-2.23.0-py2.py3-none-any.whl
https://files.pythonhosted.org/packages/18/d2/28249a71c4c550bb71358a5d73eab8ee7f14f2f99b7a45b94c46c318b99e/securesystemslib-0.14.2-py2.py3-none-any.whl
https://files.pythonhosted.org/packages/70/b8/b23170ddda9f07c3444d49accde49f2b92f97bb2f2ebc312618ef12e4bd6/setuptools-46.0.0-py3-none-any.whl
https://files.pythonhosted.org/packages/4b/c1/118ec08816737cc46b4dd93b22f7a138fbfb14b53f4b4718fd9983e70a50/setuptools_scm-3.5.0-py2.py3-none-any.whl
https://files.pythonhosted.org/packages/65/eb/1f97cb97bfc2390a276969c6fae16075da282f5058082d4cb10c6c5c1dba/six-1.14.0-py2.py3-none-any.whl
https://files.pythonhosted.org/packages/e8/74/6e4f91745020f967d09332bb2b8b9b10090957334692eb88ea4afe91b77f/urllib3-1.25.8-py2.py3-none-any.whl
https://files.pythonhosted.org/packages/8c/23/848298cccf8e40f5bbb59009b32848a4c38f4e7f3364297ab3c3e2e2cd14/wheel-0.34.2-py2.py3-none-any.whl
https://files.pythonhosted.org/packages/6d/47/dea333f2d6566e8283a0bf25e1893127b9b06ead201777a22ae7d8f81b2f/tuf-0.12.2-py2.py3-none-any.whl
EOF
)
  mkdir -p ${SOURCES}/tuf
  for s in ${sources}; do
    wget -nc -P ${SOURCES}/tuf ${s}
  done
}

pre_configure_host() {
  cat > target.req << EOF
certifi==2019.11.28 --hash=sha256:017c25db2a153ce562900032d5bc68e9f191e44e9a0f762f373977de9df1fbb3
cffi==1.14.0 --hash=sha256:2d384f4a127a15ba701207f7639d94106693b6cd64173d6c8988e2c25f3ac2b6
chardet==3.0.4 --hash=sha256:fc323ffcaeaed0e0a02bf4d117757b98aed530d9ed4531e3e15460124c106691
cryptography==2.8 --hash=sha256:3cda1f0ed8747339bbdf71b9f38ca74c7b592f24f65cdb3ab3765e4b02871651
idna==2.9 --hash=sha256:a068a21ceac8a4d63dbfd964670474107f541babbd2250d61922f029858365fa
iso8601==0.1.12 --hash=sha256:210e0134677cc0d02f6028087fee1df1e1d76d372ee1db0bf30bf66c5c1c89a3
pycparser==2.20 --hash=sha256:7582ad22678f0fcd81102833f60ef8d0e57288b6b5fb00323d101be910e35705
python-dateutil==2.8.1 --hash=sha256:75bb3f31ea686f1197762692a9ee6a7550b59fc6ca3a1f4b5d7e32fb98e2da2a
requests==2.23.0 --hash=sha256:43999036bfa82904b6af1d99e4882b560e5e2c68e5c4b0aa03b655f3d7d73fee
securesystemslib[crypto]==0.14.2 --hash=sha256:bcac34f254efc106d8717950d79d2c05ddf8d0f9eb5e31bf8fd5531b69ce7ac3
setuptools==46.0.0 --hash=sha256:693e0504490ed8420522bf6bc3aa4b0da6a9f1c80c68acfb4e959275fd04cd82
setuptools_scm==3.5.0 --hash=sha256:0d23db3d43e0a43eb7196bcf0eb8a4a2eb0561f621ed7ec44b2fdccfd907e38f
six==1.14.0 --hash=sha256:8f3cd2e254d8f793e7f3d6d9df77b92252b52637291d0f0da013c76ea2724b6c
urllib3==1.25.8 --hash=sha256:2f3db8b19923a873b3e5256dc9c2dedfa883e33d87c690d9c7913e1f40673cdc
wheel==0.34.2 --hash=sha256:df277cb51e61359aba502208d680f90c0493adec6f0e848af94948778aed386e
tuf==0.12.2 --hash=sha256:7f59abf2d82bf3e4185e94bb81a0f968b1f5d14ece2811be65763e483ad58f83
EOF
  grep -e cffi -e pycparser target.req > host.req
}

make_host() {
  python3 -m crossenv ${TOOLCHAIN}/bin/python3 .crossenv
  . .crossenv/bin/activate
  build-pip install --find-links ${SOURCES}/tuf --no-deps --no-index --require-hashes --requirement host.req
}

make_target() {
  python3 -m crossenv ${SYSROOT_PREFIX}/usr/bin/python3 .crossenv
  . .crossenv/bin/activate
  pip install --find-links ${SOURCES}/tuf --no-deps --no-index --require-hashes --requirement target.req --target=${INSTALL}
  find ${INSTALL} -name \*.py -type f -exec rm -f {} +
}
