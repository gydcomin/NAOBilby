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
ReactToTouchA = None
memory = None

class ReactToTouchA(ALModule):
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
            "ReactToTouchA",
            "onTouched")

    def onTouched(self, strVarName, value):
        """ This will be called each time a touch
        is detected.

        """
        # Unsubscribe to the event when talking,
        # to avoid repetitions
        memory.unsubscribeToEvent("TouchChanged",
            "ReactToTouchA")

        touched_bodies = []
        for p in value:
            if p[1]:
                touched_bodies.append(p[0])

        self.say(touched_bodies)

        # Subscribe again to the event
        memory.subscribeToEvent("TouchChanged",
            "ReactToTouchA",
            "onTouched")

    def say(self, bodies):
        if (bodies == []):
            return
#---------------------------------------------------------------------------

	if (bodies[1] == "Head/Touch/Front"):
		subprocess.call(['python', '/home/nao/NAO_Application/HFB/Main.py'])
	elif (bodies[1] == "Head/Touch/Middle"):
		subprocess.call(['python', '/home/nao/NAO_Application/HMB/Main.py'])
        elif (bodies[1] == "Head/Touch/Rear"):
		subprocess.call(['python', '/home/nao/NAO_Application/HRB/Main.py'])
        elif (bodies[1] == "ChestBoard/Button"):
		subprocess.call(['python', '/home/nao/NAO_Application/CB/Main.py'])
        elif (bodies[1] == "LHand/Touch/Left"):
		subprocess.call(['python', '/home/nao/NAO_Application/LHLB/Main.py'])
        elif (bodies[1] == "LHand/Touch/Back"):
		subprocess.call(['python', '/home/nao/NAO_Application/LHBB/Main.py'])
        elif (bodies[1] == "LHand/Touch/Right"):
		subprocess.call(['python', '/home/nao/NAO_Application/LHRB/Main.py'])
        elif (bodies[1] == "RHand/Touch/Left"):
		subprocess.call(['python', '/home/nao/NAO_Application/RHLB/Main.py'])
        elif (bodies[1] == "RHand/Touch/Back"):
		subprocess.call(['python', '/home/nao/NAO_Application/RHBB/Main.py'])
        elif (bodies[1] == "RHand/Touch/Right"):
		subprocess.call(['python', '/home/nao/NAO_Application/RHRB/Main.py'])
        elif (bodies[1] == "LFoot/Bumper/Left"):
		subprocess.call(['python', '/home/nao/NAO_Application/LFLB/Main.py'])
        elif (bodies[1] == "LFoot/Bumper/Right"):
		subprocess.call(['python', '/home/nao/NAO_Application/LFRB/Main.py'])
        elif (bodies[1] == "RFoot/Bumper/Left"):
		subprocess.call(['python', '/home/nao/NAO_Application/RFLB/Main.py'])
        elif (bodies[1] == "RFoot/Bumper/Right"):
		subprocess.call(['python', '/home/nao/NAO_Application/RFRB/Main.py'])
#-----------------------------------------------------------------------------

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
    tts.say("You have choosed Management program. Thanks!")

    global ReactToTouchA
    ReactToTouchA = ReactToTouchA("ReactToTouchA")

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
