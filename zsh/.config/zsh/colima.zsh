export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"

start_colima() {
  local CERTS="${HOME}/.ca-certificates"
  local URL="registry-1.docker.io:443"
  mkdir -p ${CERTS}
  openssl s_client -showcerts -connect ${URL} </dev/null 2>/dev/null|openssl x509 -outform PEM >${CERTS}/docker-com.pem
  openssl s_client -showcerts -verify 5 -connect ${URL} </dev/null 2>/dev/null | sed -ne '/-BEGIN/,/-END/p' >${CERTS}/docker-com-chain.pem
  colima start
  
  colima ssh -- sudo cp ${CERTS}/* /usr/local/share/ca-certificates/
  colima ssh -- sudo update-ca-certificates
  colima ssh -- sudo service docker restart
}
if [ -z "$(which docker-buildx)" ]; then
  mkdir -p ${HOME}/.docker/cli-plugins
  ln -s $(which docker-buildx) ${HOME}/.docker/cli-plugins/docker-buildx
fi
