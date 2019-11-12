FROM ubuntu:16.04

# Install Dependencies
RUN apt-get update -y && \
    apt-get install --assume-yes apt-utils locales-all && \
    apt-get install -y --force-yes curl && \
    apt-get install -y apt-transport-https && \
    curl -sL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c "echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list.d/google.list" && \
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
      google-chrome-stable \
      xvfb \
      libmecab-dev \
      tzdata \
      postgresql \
      postgresql-contrib \
      postgresql-client \
      unzip \
      yarn && \
    apt-get clean

# Japanese env
RUN apt-get install -y language-pack-ja-base language-pack-ja
ENV LANG=ja_JP.UTF-8

# Install Google Chrome
RUN curl -L -o google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome.deb
RUN sed -i 's|HERE/chrome\"|HERE/chrome\" --disable-setuid-sandbox|g' /opt/google/chrome/google-chrome
RUN rm google-chrome.deb
RUN google-chrome --version

# Install Chromedriver
RUN curl -O https://chromedriver.storage.googleapis.com/78.0.3904.11/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN chmod +x chromedriver
RUN mv -f chromedriver /usr/local/share/chromedriver
RUN ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
RUN ln -s /usr/local/share/chromedriver /usr/bin/chromedriver
RUN chromedriver -v

# Install Ruby 2.4.3
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:$PATH
RUN touch /root/.bash_profile && echo 'eval "$(rbenv init -)"' >> /root/.bash_profile
RUN rbenv install 2.4.3 && rbenv global 2.4.3
RUN gem i bundler

# Install Python 3.5.3
RUN git clone https://github.com/pyenv/pyenv.git /root/.pyenv
ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN CONFIGURE_OPTS="--enable-shared" pyenv install 3.5.3
RUN pyenv global 3.5.3
RUN pyenv rehash

