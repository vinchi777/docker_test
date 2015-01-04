FROM rails:4.1.8
MAINTAINER Jafet Kim L. de Veyra "jkdeveyra@gmail.com"

RUN mkdir /maxrevone
WORKDIR /maxrevone

COPY Gemfile /maxrevone/Gemfile
COPY Gemfile.lock /maxrevone/Gemfile.lock

RUN bundle install

COPY . /maxrevone

ENV RAILS_ENV production
ENV SECRET_KEY_BASE dd3faacee649ffb9a3483b8c367371f564eda4647c55ee76a058035bcc6c5c11153a9d570ece25c2afb466533dec98e4c4f08cec4bdecf4bc69ef946611e3c6d
RUN rake assets:precompile

EXPOSE 3000

CMD rails s
