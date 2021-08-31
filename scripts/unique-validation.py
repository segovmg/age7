import pprint
import pandas as pd
import sys
import json
from frictionless import validate
def unique_validation(nome):
  new_datapackage = {}
  with open('new_datapackage.json', 'w') as f:
    with open("datapackage.json", 'r', encoding='utf8') as datapackage:
      datapackage_object = json.load(datapackage)
      for key in datapackage_object:
        if key != 'resources':
          new_datapackage[key] = datapackage_object[key]
        else:
          for resource in datapackage_object[key]:
            if resource['name'] == nome:
              new_datapackage[key] = [resource]
    json.dump(new_datapackage, f, ensure_ascii=False, indent=2)
if __name__ == '__main__':
  unique_validation(sys.argv[1])