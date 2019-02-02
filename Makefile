# find setup script?
SETUP=./setup.sh

install :
	${SETUP} install && ${SETUP} create

install_nodep :
	${SETUP} create

update :
	./setup.sh update
