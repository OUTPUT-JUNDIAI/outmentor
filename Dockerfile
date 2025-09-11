FROM ruby:3.3-bookworm

# Dependências do sistema (ajuste conforme seu app: node, libpq, etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential pkg-config libyaml-dev libpq-dev \
    curl git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Gemas
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4

# Código
COPY . .

# Porta padrão
EXPOSE 3000

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
