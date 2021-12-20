import os
import yaml
import ruamel.yaml

def remove_sqs():
  path = 'schemas'
  folder = os.fsencode(path)
  for file in os.listdir(folder):
    file_name = str(file).split('\'')[1]
    if file_name.split('.')[-1] == 'yaml':
      file_path = f'{path}/{file_name}'
      file_content = load_yaml_file(file_path)
      count = 0
      with open(file_path, 'w', encoding='utf-8') as f:
        # import ipdb; ipdb.set_trace(context=10)
        for resource in file_content['fields']:
          test = resource['name'][0:4]
          if test == 'sqa_' or test == 'sqe_':
            count += 1
            print(f"Retirando campo {resource['name']} do recurso {file_name}")
            file_content['fields'].remove(resource)
        if count > 0:
          print(f"Salvando alterações no recurso {file_name}")
          yaml = ruamel.yaml.YAML(default_style='|')
          yaml.indent(sequence=4, offset=2)
          yaml.dump(file_content, f)

def load_yaml_file(file_path):
  yaml_dict_content = file_path
  yaml_dict_content = open(yaml_dict_content, encoding='utf-8').read()
  yaml_dict_content = yaml.load(yaml_dict_content, Loader=yaml.FullLoader)
  return yaml_dict_content

remove_sqs()
