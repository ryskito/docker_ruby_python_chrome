FROM ryskito/docker_ruby_python_chrome:ruby2.4.3-python3.5.3-chrome73

RUN ruby -v
RUN python -V
RUN google-chrome --version
RUN chromedriver --version

# Install Dependencies
RUN apt-get update -y && \
    apt-get install --assume-yes apt-utils locales-all && \
    apt-get install -y --force-yes curl && \
    apt-get install -y apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get update -y && \
    apt-get install -y --force-yes build-essential && \
    apt-get install -y --force-yes \
      vim \
      tar \
      git \
      binutils \
      libffi-dev \
      libgdal-dev \
      libpq-dev \
      libreadline-dev \
      libssl-dev \
      libstdc++6 \
      libxml2-dev \
      libxslt-dev \
      libyaml-dev \
      libproj-dev \
      proj-data \
      zlib1g-dev \
      nodejs \
      net-tools \
      imagemagick \
      libmagickwand-dev \
      xvfb \
      libmecab-dev \
      tzdata \
      postgresql-client \
      unzip \
      yarn && \
    apt-get clean
