FROM python:3.10-slim

ENV PYTHONFAULTHANDLER=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONHASHSEED=random \
  PIP_NO_CACHE_DIR=off \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_DEFAULT_TIMEOUT=100 \
  POETRY_VIRTUALENVS_CREATE=false

RUN mkdir /app
RUN pip install poetry==1.1.11
WORKDIR /app

COPY poetry.lock pyproject.toml ./

RUN poetry install --no-dev --no-interaction --no-ansi \
    && pip uninstall --yes poetry


COPY . ./
CMD ["uvicorn", "randomservice.app:app", "--host", "0.0.0.0", "--port", "8080"]