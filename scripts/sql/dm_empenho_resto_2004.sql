select id_empenho,
ano_exercicio,
sqa_restoapagar,
sqa_gmifp,
sqa_unidade_exec,
sqa_unidade_orc,
sqa_credor,
sqa_natureza,
sqa_tpdocumento,
nr_empenho,
dt_empenho,
dt_original,
unidade_orcamentaria,
unidade_executora,
funcao,
subfuncao,
programa,
acao,
categoria_econ,
grupo_desp,
elemento_desp,
item_desp,
modalidade_aplic,
tipo_empenho,
fonte_recurso,
identificador_orc,
razao_social_credor,
vr_empenho
from dm_empenho_resto
where ano_exercicio = 2004

