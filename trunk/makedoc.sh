#!/bin/sh

APPNAME=NetUtil
APPVERSION=0.33

echo "=========================================="
echo "= this script creates html javadoc files ="
echo "= in a subfolder 'doc' in the current    ="
echo "= work directory. Be sure to cd into the ="
echo "= $APPNAME folder before running this"
echo "= script!!!                              ="
echo "=========================================="
echo
echo "NOTE : escape white spaces in path names with %20"
echo

# APPHOME=/Applications/Meloncillo
PACKAGES="de.sciss.net de.sciss.net.test"
CLASSPATH=
# CLASSPATH=libraries/MRJAdapter.jar:libraries/jatha.jar
JAVADOC_OPTIONS="-quiet -use -tag synchronization -tag todo -tag warning -source 1.4 -version -author -sourcepath src/ -d doc/api"
WINDOW_TITLE="$APPNAME v$APPVERSION API"

GLOBAL_JAVA=http://java.sun.com/j2se/1.4.2/docs/api/

REFER_OFFLINE=0
read -er -p "Let javadoc use local API copies when creating docs (y,N)? "
for f in Y y j J; do if [ "$REPLY" = $f ]; then REFER_OFFLINE=1; fi done
LINK_OFFLINE=0
read -er -p "Should the resulting HTML files link to local API copies (y,N)? "
for f in Y y j J; do if [ "$REPLY" = $f ]; then LINK_OFFLINE=1; fi done

# cd $APPHOME

if [ $(($REFER_OFFLINE|LINK_OFFLINE)) != 0 ]; then
  LOCAL_JAVA="/Developer/ADC%20Reference%20Library/documentation/Java/Reference/1.4.2/doc/api"
  read -er -p "Local Java 1.4.2 API folder ('$LOCAL_JAVA')? "
  if [ "$REPLY" != "" ]; then LOCAL_JAVA="$REPLY"; fi
# LOCAL_JATHA="/Volumes/Claude/Developer/jatha/doc/api"
# read -er -p "Local Jatha API folder ('$LOCAL_JATHA')? "
# if [ "$REPLY" != "" ]; then LOCAL_JATHA="$REPLY"; fi
# LOCAL_MRJ="/Volumes/Claude/Developer/MRJAdapter/Documentation"
# read -er -p "Local MRJAdapter API folder ('$LOCAL_MRJ')? "
# if [ "$REPLY" != "" ]; then LOCAL_MRJ="$REPLY"; fi
  
  if [ $LINK_OFFLINE != 0 ]; then
#   javadoc $JAVADOC_OPTIONS -windowtitle "$WINDOW_TITLE" -link "file://$LOCAL_JAVA" -link "file://$LOCAL_JATHA" -link "file://$LOCAL_MRJ" -classpath $CLASSPATH $PACKAGES;
  	LINK_OPTIONS="-link file://$LOCAL_JAVA"
  else
#   javadoc $JAVADOC_OPTIONS -windowtitle "$WINDOW_TITLE" -linkoffline http://java.sun.com/j2se/1.4.2/docs/api/ "file://$LOCAL_JAVA" -linkoffline http://jatha.sourceforge.net/doc/api/ "file://$LOCAL_JATHA" -linkoffline http://www.roydesign.net/mrjadapter/apidoc/ "file://$LOCAL_MRJ" -classpath $CLASSPATH $PACKAGES;
    LINK_OPTIONS="-linkoffline $GLOBAL_JAVA file://$LOCAL_JAVA"
  fi;
else
# javadoc $JAVADOC_OPTIONS -windowtitle "$WINDOW_TITLE" -link http://java.sun.com/j2se/1.4.2/docs/api/ -link http://jatha.sourceforge.net/doc/api/ -link http://www.roydesign.net/mrjadapter/apidoc/ -classpath $CLASSPATH $PACKAGES;
	LINK_OPTIONS="-link $GLOBAL_JAVA"
fi

CMD="javadoc $JAVADOC_OPTIONS $LINK_OPTIONS $CLASSPATH $PACKAGES"
echo $CMD
$CMD

echo "---------- done ----------"
