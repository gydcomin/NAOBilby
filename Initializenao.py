# -*- encoding: UTF-8 -*-

""" Say `My {Body_part} is touched` when receiving a touch event
"""

import sys
import time

from naoqi import ALProxy
from naoqi import ALBroker
from naoqi import ALModule
import argparse
import subprocess

# Global variable to store the ReactToTouch module instance
ReactToTouch = None
memory = None

class ReactToTouch(ALModule):
    """ A simple module able to react
        to touch events.
    """
    def __init__(self, name):
        ALModule.__init__(self, name)
        # No need for IP and port here because
        # we have our Python broker connected to NAOqi broker

        # Create a proxy to ALTextToSpeech for later use
        self.tts = ALProxy("ALTextToSpeech")

        # Subscribe to TouchChanged event:
        global memory
        memory = ALProxy("ALMemory")
        memory.subscribeToEvent("TouchChanged",
            "ReactToTouch",
            "onTouched")

    def onTouched(self, strVarName, value):
        """ This will be called each time a touch
        is detected.

        """
        # Unsubscribe to the event when talking,
        # to avoid repetitions
        memory.unsubscribeToEvent("TouchChanged",
            "ReactToTouch")

        touched_bodies = []
        for p in value:
            if p[1]:
                touched_bodies.append(p[0])

        self.say(touched_bodies)

        # Subscribe again to the event
        memory.subscribeToEvent("TouchChanged",
            "ReactToTouch",
            "onTouched")

    def say(self, bodies):
        if (bodies == []):
            return
#---------------------------------------------------------------------------------------
	if (bodies[1] == "Head/Touch/Rear"):
		subprocess.call(['python', '/home/nao/Main.py'])
	elif (bodies[1] == "Head/Touch/Front"):
		sys.exit(0)
	else:
		self.tts.say("Choose the correct button. Head Rear for Management Program and Head Front for normal")



#-----------------------------------------------------------------------------------------	

def main(ip, port):
    """ Main entry point
    """
    # We need this broker to be able to construct
    # NAOqi modules and subscribe to other modules
    # The broker must stay alive until the program exists
    myBroker = ALBroker("myBroker",
       "0.0.0.0",   # listen to anyone
       0,           # find a free port and use it
       ip,          # parent broker IP
       port)        # parent broker port

    tts = ALProxy("ALTextToSpeech")
    tts.say("Choose the correct button. Head Rear for Management Program and Head Front for normal")
    global ReactToTouch
    ReactToTouch = ReactToTouch("ReactToTouch")

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print
        print "Interrupted by user, shutting down"
        myBroker.shutdown()
        sys.exit(0)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--ip", type=str, default="127.0.0.1",
                        help="Robot ip address")
    parser.add_argument("--port", type=int, default=9559,
                        help="Robot port number")
    args = parser.parse_args()
    main(args.ip, args.port)
