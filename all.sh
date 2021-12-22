cd $PROJECT_PATH
source venv/Scripts/activate
{
git pull && \
make parse && \
make extract && \
# make full-extract && \
git add . && git commit -m "Atualização age7"
} > logs/all.txt
echo $? > logs/exit-code.txt
git rev-parse --short HEAD > logs/commit.txt
# make notify
git add logs/notify.Rout && git commit -m "Log make notify"
git push origin master
