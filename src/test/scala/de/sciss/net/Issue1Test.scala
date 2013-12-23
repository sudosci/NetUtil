package de.sciss.net

object Issue1Test extends App {
  val server = OSCServer.newUsing(OSCChannel.TCP)
  server.start()

  val client = OSCClient.newUsing(OSCChannel.TCP)
  client.setTarget(server.getLocalAddress)
  client.start()

  new Thread {
    override def run(): Unit = {
      Thread.sleep(1000)
      println("Stopping client.")
      client.stop()
      Thread.sleep(8000)
      println("Quitting")
      sys.exit(0)
    }

    start()
  }
}
