{
make parse && \
make full-extract && \
make ingest && \
make data && \
make validate && \
make datapackage.json && \
make test && \
make build
} > logs/run.txt