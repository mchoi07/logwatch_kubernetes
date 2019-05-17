from machine.plugins.base import MachineBasePlugin
from machine.plugins.decorators import process
import json

class LoggerPlugin(MachineBasePlugin):

	@process("message")
	def record(self, event):
		print("Event received.")
		with(open('slack_machine.log', 'a'))as file:
			print("File opened.")
			file.write(json.dumps(event))
			print("Record written?")
			file.close()
			print("File closed.")
