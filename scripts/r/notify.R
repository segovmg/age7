outlb <- Microsoft365R::get_business_outlook()

body <- blastula::render_email(here::here("scripts", "r", "notify.Rmd"))

em <- outlb$create_email(body,
                         subject = paste("Atualização age7 em:", date()),
                         to = "catalogo.dadosabertos@cge.mg.gov.br")
em$send()
