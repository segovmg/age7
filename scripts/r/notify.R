outlb <- Microsoft365R::get_business_outlook()

body <- blastula::render_email(here::here("scripts", "r", "notify.Rmd"))

exit_code <- readLines(here::here("logs/exit-code.txt"))
status <- ifelse(exit_code == 0, "SUCESSO", "FRACASSO")

em <- outlb$create_email(body,
                         subject = glue::glue("[{status}] Atualização age7 em: {date()}"),
                         to = "catalogo.dadosabertos@cge.mg.gov.br")
em$send()
