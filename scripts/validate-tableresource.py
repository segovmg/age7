import sys
# from pathlib import Path, PurePath
#from pprint import pprint
#from datapackage import Package
#from frictionless import validate_resource
#from frictionless import validate_schema
#from schema import Schema

#def validate_tableresource (resource):
    #package = Package('datapackage.json')
    #for resource in package.resources:
        #report = validate_resource(resource.source, schema)
        #print(report)


from pprint import pprint
from frictionless import validate

def validate_tableresource(resource):
    report = validate(resource)
    pprint(report.flatten(["rowPosition", "fieldPosition", "code"]))

if __name__ == '__main__':
   validate_tableresource(sys.argv[1])