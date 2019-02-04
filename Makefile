# find setup script?
SETUP=./setup.sh

install :
	${SETUP} install && ${SETUP} create && ${SETUP} nvim

install_nodep :
	${SETUP} create

update :
	${SETUP} update

.PHONY: nvim
nvim :
	${SETUP} nvim
