FROM ruby:2.6.3


# 创建在var里面，还能够添加更多的app? 其实一般就只有一个
# 因为我们可以建立多个容器
ENV APP_PATH=/var/app
RUN mkdir $APP_PATH
WORKDIR $APP_PATH

COPY ./sources.list /etc/apt/sources.list
# 替换为国内源，如果是ubuntu系统可以用下面的办法
# RUN  sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list

#  update之前需要添加yarn的源
RUN  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq

# 有个vim, 进入容器内编辑文件还是非常方便的！
RUN apt-get install -y vim
# 学习时需要使用sqlite3
RUN apt-get install -y libsqlite3-dev
# 安装postgresql
RUN apt-get install -y postgresql-client
# 用于图片上传
RUN apt-get install -y imagemagick
RUN apt-get install -y nodejs
RUN apt-get install yarn

RUN  apt-get clean
# ENV BUNDLE_PATH vendor/bundle
# gems中国镜像，加速gems的安装
RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.com
# # 当Gemfile 没有改变时，省略下面的 bundle install
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install
# 将 Dockerfile 目录下所有内容复制到容器工作目录
COPY . .

EXPOSE 3000
CMD rails server -b 0.0.0.0 -p 3000
