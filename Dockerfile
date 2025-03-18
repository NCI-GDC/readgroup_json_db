ARG REGISTRY=docker.osdc.io/ncigdc
ARG BASE_CONTAINER_VERSION=latest

FROM ${REGISTRY}/python3.9-builder:${BASE_CONTAINER_VERSION} as builder

COPY ./ /readgroup_json_db

WORKDIR /readgroup_json_db

RUN pip install tox && tox -e build

FROM ${REGISTRY}/python3.9:${BASE_CONTAINER_VERSION}

LABEL org.opencontainers.image.title="readgroup_json_db" \
      org.opencontainers.image.description="readgroup_json_db" \
      org.opencontainers.image.source="https://github.com/NCI-GDC/readgroup_json_db" \
      org.opencontainers.image.vendor="NCI GDC"

COPY --from=builder /readgroup_json_db/dist/*.whl /readgroup_json_db/
COPY requirements.txt /readgroup_json_db/

WORKDIR /readgroup_json_db

RUN pip install --no-deps -r requirements.txt \
	&& pip install --no-deps *.whl \
	&& rm -f *.whl requirements.txt

USER app

ENTRYPOINT ["readgroup_json_db"]

CMD ["--help"]
