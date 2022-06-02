import os
import json

path = 'logs/validate'
folder = os.fsencode(path)

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
	    	if file_content['tasks'][0]['resource']['stats']['rows'] == 0:
	    		resource_name = filename.split('.')[0]
	    		os.system(f'echo Rerun {resource_name} 0 row extraction >> logs/check_empty_resource.txt')
	    		os.system(f'rm -f data/raw/{resource_name}.csv >> logs/check_empty_resource.txt')
	    		os.system(f'rm -f data/staging/{resource_name}.csv >> logs/check_empty_resource.txt')
	    		os.system(f'rm -f data/{resource_name}.csv.gz >> logs/check_empty_resource.txt')
	    		os.system(f'dtamg-py etl-make extract --resource {resource_name} > logs/extract/{resource_name}.txt')
	    		os.system(f'rsync --itemize-changes --checksum data/raw/{resource_name}.csv data/staging/{resource_name}.csv 2> logs/ingest.txt')
	    		os.system(f'gzip -n < data/staging/{resource_name}.csv > data/{resource_name}.csv.gz')
	    		os.system(f'dtamg-py etl-make validate -r {resource_name} > logs/validate/{filename}')