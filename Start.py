from naoqi import ALProxy
import subprocess
tts = ALProxy("ALTextToSpeech", "0.0.0.0", 9559)
tts.say("Hello, Everyone!!!")


subprocess.call(['python', '/home/nao/Initializenao.py'])
