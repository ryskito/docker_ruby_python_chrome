FROM ryskito/docker_ruby_python_chrome:ruby2.6.3_python3.7.3

RUN google-chrome --version

RUN chromedriver --version

# Install Ruby 2.4.3
RUN rbenv install 2.4.3 && rbenv global 2.4.3
RUN gem i bundler

# Install Python 3.5.3
RUN CONFIGURE_OPTS="--enable-shared" pyenv install 3.5.3
RUN pyenv global 3.5.3
RUN pyenv rehash

