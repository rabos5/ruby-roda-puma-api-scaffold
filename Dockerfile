FROM ubuntu:latest

ENV TERM xterm-256color

# set rvm / ruby specific environment variables:
ENV GEM_HOME /usr/local/rvm/gems/ruby-2.6.3
ENV GEM_PATH /usr/local/rvm/gems/ruby-2.6.3:/usr/local/rvm/gems/ruby-2.6.3@global
ENV PATH $PATH:/usr/local/rvm/bin
ENV PATH $PATH:/usr/local/rvm/rubies/ruby-2.6.3/bin
ENV PATH /usr/local/rvm/gems/ruby-2.6.3/bin:$PATH
ENV PATH $PATH:/usr/local/rvm/gems/ruby-2.6.3@global/bin

# install / setup ruby:
RUN apt-get -qq update -y \
    && apt-get -qq -y install gnupg2 \
    && apt-get -qq -y install curl \
    && curl -sSL https://rvm.io/mpapis.asc | gpg2 --import - \
    && curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import - \
    && curl -sSL https://get.rvm.io | bash -s stable --ruby=2.6.3

RUN /bin/bash -l -c "source /usr/local/rvm/scripts/rvm"
RUN /bin/bash -l -c "source /etc/profile.d/rvm.sh"
RUN /bin/bash -l -c "rvm use 2.6.3 --default"
RUN echo "[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*" >> /root/.bashrc

# install bundler gem:
RUN gem install bundler -s https://rubygems.org --no-document

# update and install utilities:
RUN apt-get -qq update -y \
    && apt-get install -y wget xz-utils unzip \
    && rm -rf /var/lib/apt/lists/*

# install build tools:
RUN apt-get -qq update -y \
    && apt-get install -y python git build-essential libaio1 libaio-dev libxml2 libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# install gems from Gemfile:
RUN echo "install: --no-document" >> ~/.gemrc
RUN echo "update: --no-document" >> ~/.gemrc
RUN chmod -R 777 /usr/local/rvm/
RUN mkdir /apps/
RUN mkdir /apps/sample/
COPY Gemfile /apps/sample/
COPY Gemfile.lock /apps/sample/
RUN cd /apps/sample/ && bundle install
RUN chmod -R 777 /usr/local/rvm/

# setup application / working directory:
COPY config/puma.rb /apps/sample/config/
RUN mkdir /apps/sample/config/certs/
RUN mkdir /apps/security/
COPY core /apps/sample/core
COPY routes /apps/sample/routes
COPY .env.dev /apps/sample/
COPY config.ru /apps/sample/
COPY app.rb /apps/sample/
COPY app_setup.rb /apps/sample/

# final update:
RUN apt-get -qq update -y

# start up application:
WORKDIR /apps/sample/
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /apps/sample/config/certs/pkey.pem -out /apps/sample/config/certs/cert.crt -subj "/C=US/O=sample_org/OU=sample_org_unit/CN=localhost"
CMD ["sh", "-c", "bundle exec puma -C config/puma.rb"]
