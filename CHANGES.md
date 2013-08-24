# Change History

In the course of the development of NetUtil, some API changes were made. Generally, changing the API is considered bad because it breaks previous code (it is not backward compatible). However, I tried to minimize these changes. Generally, changes have only been made, when the API proved suboptimal or new features were added which would introduce ugly API when enforcing backward compatibility.

This document tries to help updating code that uses old versions of NetUtil.

## v0.39 (jun 2011 - SVN rev. 23)</h4>

- OSCClient and OSCTransmitter creation: socket's IP defaults to "0.0.0.0" now instead of InetAddress.getLocalHost(). Allegedly that was responsible for an issue on Android.

## v0.38 (may 2009 - SVN rev. 21)

- Removed makedoc.sh in favour of a doc ant target

## v0.37 (may 2009 - SVN rev. 18)

- OSCServer creation: socket's IP defaults to "0.0.0.0" now instead of InetAddress.getLocalHost(); added tests

## v0.36 (may 2009 - SVN rev. 16)

- Fixed bug in OSCReceiver.newUsing( DatagramChannel )
- Increased OSCPacketCodec.Atom visibility
- Fixed confusing error message with null OSC message arguments
- Fixed typo: OSCBundle.setTimeTagRow becomes setTimeTagRaw
- OSCReceiver creation: socket's IP defaults to "0.0.0.0" now instead of InetAddress.getLocalHost(), since this way messages both from localhost and loopback sockets are received.

## v0.35 (apr 2008 - SVN rev. 6)

- Improved and fixed javadoc comments for OSCTransmitter, OSCReceiver, OSCClient, OSCServer

## v0.34 (apr 2008 - SVN rev. 5)

- Added javadoc comments for OSCPacketCodec

## v0.33 (jul 2007)

- Added separate OSCPacketCodec class and factory methods for OSCClient, OSCServer, OSCTransmitter, OSCReceiver, using this new codec. The codec allows to specify 64-bit primitives behaviour among others. The SpecificOSCMessage class was dropped.
- String ('s' type) argument decoding now follows the given codec. Default codec uses UTF-8 on all platforms.
- Bug fix in OSCTransmitter.newUsing( String, int ).
- Slightly increased decoding performance.

## v0.32 (mar 2007)

- String ('s' type) argument decoding correctly uses platform default charset for ascii characters >127.
- using Eclipse and Ant now.

## v0.31 (oct 2006)

- Allows &quot;revivable&quot; channels and clients. Improved TCP support.

## v0.30 (oct 2006)

- Integration of TCP mode as alternative to UDP.
- This suggested API changes (see separate section at the end of this document).
- New classes <code>OSCClient</code> and <code>OSCServer</code> simplify the use of receivers and transmitters.
- Improved javadocs

## v0.26 (jul 2006)

- Minor improvements in OSCReceiver

## v0.25 (nov 2005)

- Bug fixes : decoding blob arguments

## v0.24 (sep 2005)

- API change: the <code>OSCListener</code> interface is modified to include the timetag of the incoming message.
- Bug fixes : byte boundary alignment of blobs, packet size calculation with blobs and nested messages.
- Small improvements (hexdump looks better + receiver thread catches runtime exceptions)

## v0.22 (sep 2005)

- OSCMessage allows byte[] arguments which are encoded as a blob.

## v0.2 (aug 2005)

- <code>OSCReceiver</code> is accompanied by a new <code>OSCTransmitter</code> class which is really simple but saves you from typing the same five lines over and over again. Their common super class is <code>AbstractOSCCommunicator</code> which provides a <code>dumpOSC</code> method.
- It turned out that binding an unbound channel in the <code>OSCReceiver</code> constructor to <code>&quot;127.0.0.1&quot;</code> would silently disallow that channel to send messages outside the local computer. The behaviour has therefore changed to bind the channel to the loopback address only if the filter address is a loopback address (indicating usage on the local machine only), otherwise the local IP address is used.

## v0.14 (aug 2005)

- OSCReceiver has a new contract of not allowing channels to be connected. This allows you to use the channel both for sending and receiving messages. Print messages have been added to OSCPacket and a debugDump method to OSCReceiver

## v0.12 (jul 2005)

- tries to avoid a runtime error discovered on linux (sun jdk 1.5)

## v0.11 (jun 2005)

- first version, an extract from meloncillo basically

# API Changes

The following sections only highlight backward incompatible API changes.

## API changes from v0.22 to v0.24

 - in interface de.sciss.net.OSCListener
  old signature:

			public void messageReceived( OSCMessage m, SocketAddress addr );

  new signature:

			public void messageReceived( OSCMessage m, SocketAddress addr, long when );

  this change was necessary to pass bundle execution times to the listener. to update
  old code, simply replace the old signatures with the new ones and ignore the
  bundle time (long when).

## API changes from v0.26 to v0.30

- these changes were made in the course of TCP integration
	- deletion of class de.sciss.net.AbstractOSCCommunicator
		why? the class was too specific about the network channel type. the class name
		is ugly. the class was used to define constants, which is generally done
		by using an interface.

		therefore, the interface de.sciss.net.OSCChannel was created which includes
		some of the methods of AbstractOSCCommunicator.

		in your code, try to replace references to AbstractOSCCommunicator by their
		concrete subclass OSCReceiver or OSCTransmitter. Getting the DatagramChannel
		is impossible now. Instead memorize the channel you pass to one of the
		constructors in OSCReceiver or OSCTransmitter. If you used the empty
		constructor, create an explicit channel that can be memorized.

		if you just need to learn the local socket address, you can call
		getLocalAddress() now.

	- de.sciss.net.OSCReceiver and de.sciss.net.OSCTransmitter became abstract
		making these classes abstract provides a much more beautiful way of dealing
		with different transport types than using internal delegates.

		this implies that you cannot construct instances directly. instead new
		static methods newUsing() are provided. examples:

			old code:	rcv = new OSCReceiver();
			new code:	rcv = OSCReceiver.newUsing( OSCReceiver.UDP );

			old code:	rcv = new OSCReceiver( myChannel, myAddr, myBufSize );
			new code:	myChannel.socket().bind( myLocalAddr );
					rcv = OSCReceiver.newUsing( myChannel );
					rcv.setBufferSize( myBufSize );
					// note: filtering for myAddr is not possible any more
					// ; this will be addressed in OSCServer in a next version

		however, things have been further simplified with the introduction of classes
		de.sciss.net.OSCClient and de.sciss.net.OSCServer, so you may wish to exchange
		a combo instantiation of OSCReceiver and OSCTransmitter by one of these classes.

## API changes from v0.32 to v0.33

- these changes were made in the course of codec customization
	- removals in OSCBundle
		decodeBundle( ByteBuffer b, Map m ) removed

	- removals in OSCPacket
		protected codec helping field 'pad' and methods 'readString', 'terminateAndPadToAlign',
		'padToAlign', 'skipToValues', 'skipToAlign' removed or moved to OSCPacketCodec.

	- changes in OSCPacket
		getSize is final now, not abstract any more.
		encode is final now, not abstract any more.
		encode doesn't throw BufferOverflowException any more.
		decode doesn't throw BufferUnderflowException any more.
		
		old signature:
			public static OSCPacket decode( ByteBuffer b, Map m )
		new signature:
			public static OSCPacket decode( ByteBuffer b )

		(due to removal of SpecificOSCMessage)

	- removals in OSCReceiver
		setCustomMessageDecoders() was removed (due to removal of SpecificOSCMessage).

	- changes in OSCTransmitter
		send( OSCPacket p, SocketAddress target ) is final now, not abstract any more

	- removal of SpecificOSCMessage
		this class war very ugly and unflexible. to use specifically optimized message
		encoding / decoding, you should instead subclass OSCPacketCodec and overwrite
		the corresponding encode() and decode() methods. A possible conversion approach
		you can find in SwingOSC v0.53+'s ScopeView and OSCSharedBufSetNMsg classes.

## API changes from v0.36 to v0.35

- OSCReceiver binds to IP "0.0.0.0" instead of InetAddress.getLocalHost() when loopBack is false.
  This allows sockets bound to loopback to send to those receivers, too.
	- changes in OSCChannel
		getLocalAddress now throws an IOException. In order to prevent problems with
		returning "0.0.0.0", in such case InetAddress.getLocalHost() is returned which is
		most likely the desired result, besides staying mostly backwards compatible.
		getLocalHost() may throw however the IOException (UnknownHostException).

## API changes from v0.38 to v0.39

- OSCTransmitter binds to IP "0.0.0.0" instead of InetAddress.getLocalHost() when loopBack is false.
  Apparently that allows them to connect from Android.
- OSCTransmitter getLocalAddress throws IOException now, as it also resolves IP 0.0.0.0 like OSCReceiver

