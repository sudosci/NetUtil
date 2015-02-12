# NetUtil

[![Flattr this](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=sciss&url=https%3A%2F%2Fgithub.com%2FSciss%2FNetUtil&title=NetUtil%20OSC%20Library&language=Java&tags=github&category=software)
[![Maven Central](https://maven-badges.herokuapp.com/maven-central/de.sciss/netutil/badge.svg)](https://maven-badges.herokuapp.com/maven-central/de.sciss/netutil)

## statement

NetUtil is a compact and efficient Java library for sending and receiving messages using the OpenSoundControl (OSC) protocol. It is (C)opyright 2004&ndash;2013 by Hanns Holger Rutz. All rights reserved. NetUtil is released under the [GNU Lesser General Public License](https://raw.github.com/Sciss/NetUtil/master/LICENSE) and comes with absolutely no warranties. To contact the author, send an email to `contact at sciss.de`.

For project status, API and current version, visit [github.com/Sciss/NetUtil](https://github.com/Sciss/NetUtil).

Note that this project is not actively developed any more (unless there are bugs to fix). For a current OSC library in the Scala programming language, please visit [github.com/Sciss/ScalaOSC](https://github.com/Sciss/ScalaOSC).

## requirements / building

NetUtil requires Java 1.4+. NetUtil has also been successfuly running on Android. It uses [sbt](http://sbt.github.com/) 0.13 for building. You can use the included `sbt` shell script if you do not want to install sbt.

To compile `sbt compile`, to generate a jar `sbt package`.

## linking

To use NetUtil in your project, you can link to the following [Maven](http://search.maven.org) artifact:

    GroupId: de.sciss
    ArtifactId: netutil
    Version: 1.0.0

## documentation

Documentation comes in the form of JavaDoc. The generate the docs, run `sbt doc`. The resulting file is in `target/api/index.html`.

You can run some demos using `sbt`. First run `./sbt`. At the prompt:

    > run

This will print to available options. E.g.

    > run --testPingPong

## noteworthy links

- [www.opensoundcontrol.org](http://www.opensoundcontrol.org) &ndash; information about OSC specifications and implementations
- [Illposed JavaOSC](http://www.illposed.com/software/javaosc.html) &ndash; another OSC library for Java
- [oscP5](http://www.sojamo.de/iv/index.php?n=11) &ndash; OSC library for Processing
- [flosc](http://www.benchun.net/flosc/) &ndash; OSC library (written in Java) for bridging OSC clients and Macromedia Flash
- [jmDNS](http://jmdns.sourceforge.net/) &ndash; automatic service discovery library for Java.

Here is some sporadic list of projects which seem to use NetUtil. if you want to have your project added here, send me the links:

- [Androidome](http://code.google.com/p/androidome/) &ndash; android-based emulator for the monome music making device
- [jReality](http://www3.math.tu-berlin.de/jreality/)
- [OscVstBridge](http://www.savedbytechnology.com/main4/oscvstbridge.htm) &ndash; VST plug-in
- [Frozen Bubble OSCified](http://blog.cappel-nord.de/2008/07/frozen-bubble/)
- [DiABlu](http://diablu.jorgecardoso.eu/) &ndash; Scout and LegOSC
- [AMICO](http://amico.sourceforge.net/)
- [Protocoder](http://www.protocoder.org/)

## to-do / known issues

- add special client and server listeners so one can detect channels/connections opening and closing
- add helper classes (multi-server wrapper, message deferrer)

