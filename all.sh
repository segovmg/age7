cd $PROJECT_PATH
source venv/Scripts/activate
git pull && \
make parse && \
git add . && \
git commit -m "Atualização age7" && \
git push origin master
echo $? > logs/exit-code.txt
git rev-parse --short HEAD > logs/commit.txt
make notify
