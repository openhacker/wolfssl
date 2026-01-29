#! /bin/bash

# defaults to putting the output in $PWD/output
# figure out if we're crossing with the contents of $CC

set -e

OUTPUT_DIRECTORY=$PWD/output

echo putting output in $OUTPUT_DIRECTORY


if [  ! -e configure ]; then
	echo running autogen
	./autogen.sh
fi

exit

function test_crosscompiler
{
	if [ -z "${CC}" ]; then
		return;
	fi

	OLDIFS="$IFS"
	IFS=-
	
	set -- ${CC}

	echo Number of options $#
	if [ $# -gt 3  ]
	then
		HOST_CONFIG="--host=$1-$2-$3"
		export CROSS=1

	fi
	IFS="$OLDIFS"
}




test_crosscompiler 

# to cross compile add --host=aarch64-linux-gnu and $CROSS=1
#
./configure  --enable-mlkem --enable-mldsa -prefix=$OUTPUT_DIRECTORY  "$HOST_CONFIG"
make
make install


