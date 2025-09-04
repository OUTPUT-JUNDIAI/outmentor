# Rails 8 (Ruby 3.3+) + Postgres client + Node (para projetos com jsbundling/vite/esbuild)
FROM ruby:3.3-slim

# Variáveis básicas
ENV RAILS_ENV=development \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

# Dependências do sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential git curl \
    libpq-dev postgresql-client \
    nodejs npm \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Cache de gems: copie Gemfile(s) antes
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Copie o restante do app
COPY . .

# Porta padrão do Rails
EXPOSE 3000

# Comando padrão: prepara DB e sobe o servidor
CMD ["bash", "-lc", "bundle exec rails db:prepare && bundle exec rails s -b 0.0.0.0 -p 3000"]
