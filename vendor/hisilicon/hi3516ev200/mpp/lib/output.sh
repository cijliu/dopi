#!/bin/sh
LIBMPP=libmpp.a
CROSS_COMPILER=arm-himix100-linux-
AR=${CROSS_COMPILER}ar 
RANLIB=${CROSS_COMPILER}ranlib
mv ../sample/common/*.o ./
rm -rf libmpp.a
for file in $(find ./ -name "*.a"|tr " " "?")
do
if [[ "${file}" =~ ".a" ]]
then
${AR} x ${file} 
fi
done
mkdir -p output 
mv *.o output
#${AR} cru ${LIBMPP} *.o && ${RANLIB}  ${LIBMPP} && rm *.o

