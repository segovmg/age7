# Validações Conjuntos AGE7

Validação realizada em: **{{ frictionless.Resource("logs/validate/failed_reports.json")['formated_date'] }}**

{% if frictionless.Resource("logs/validate/failed_reports.json")['valid'] == True  %}
Todos os recursos válidos: **Sim**
{% else  %}
Todos os recursos válidos: **Não**
{% extends "reports.md" %}
{% endif %}