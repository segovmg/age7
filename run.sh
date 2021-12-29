{
make parse && \
make extract && \
make ingest && \
make data && \
make validate && \
make datapackage.json && \
make test && \
make build
} > logs/run.txt
echo $? > logs/exit-code.txt
git rev-parse --short HEAD > logs/commit.txt
make notify
