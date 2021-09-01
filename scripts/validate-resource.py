import ipdb
import os
import sys
from datapackage import Package
from goodtables import validate

def resource_validation(resource_name):
  ipdb.set_trace(context=5)
  package = Package('datapackage.json')
  resource = package.get_resource(resource_name)
  report = validate(resource.source, schema=resource.schema.descriptor)
  print(report)
  
if __name__ == '__main__':
    resource_validation(sys.argv[1])
