import os
import json

path = 'logs/validate'
folder = os.fsencode(path)
failed_tasks = []
errors = 0
# Iterate over all reports file in logs/validate folder
for file in os.listdir(folder):
    filename = os.fsdecode(file)
    # build report's file path
    file_path = f'{path}/{filename}'
    with open(file_path, 'r', encoding='utf8') as json_file:
    	# Load file content as python dictionary (json file to dictionary)
    	if file_path != 'logs/validate/.gitkeep' and file_path != 'logs/validate/failed_reports.json':
	    	file_content = json.load(json_file)
	    	# Check valid property to see if validation passed
	    	if file_content['valid'] == False:
	    		# Add Failed validations to failed_tasks list previosly created
	    		failed_tasks.append(file_content['tasks'][0])
	    		errors += len(file_content['tasks'][0]['errors'])
# Add failed valitations to failed_reports.json file
if len(failed_tasks) > 0:
	file_content = {
		"version": "4.22.3",
		"time": 0.001,
		"errors": [],
		"tasks": [],
		"stats": {
		    "errors": errors,
		    "tasks": len(failed_tasks)
		  	},
	  	"valid": False
	}
	# Iterate over most recenly failed validations		
	for failed_task in failed_tasks:
		file_content['tasks'].append(failed_task)
	with open(f'{path}/failed_reports.json', 'w') as new_json_file:
		# Write new failed validations on failed_reports.json file
		json.dump(file_content, new_json_file, ensure_ascii=False, indent=2)