# docker-china-rails6

本docker使用ruby2.6.3, rails6.0.0建立，供学习使用，文件模板使用缺省配置。

```
git clone https://github.com/dayudodo/docker-china-rails6
cd docker-china-rails6

# 创建镜像
docker build -t demo/docker-china-rails6 .

# docker-compose run --rm app yarn install
docker-compose up
docker-compose exec app bundle exec rails db:create
```

打开 http://localhost:4000/ 看效果。（compose里面设置宿主机端口号4000对应容器内的3000端口）


## pry

If you want to attach a docker process after you stop at a break point with pry, use the following command.

```
$ ./bin/docker-compose-attach app
```

## 其它说明
- Dockerfile中已经修改rubygems映像为china镜像。
```
RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.com
```
- 所有的gems安装在项目目录中，并没有安装在容器内，由docker-compose.yml中的BUNDLE_PATH控制。
```
    environment:
      - BUNDLE_PATH=/var/app/vendor/bundle
```
- 如何使用容器来新建一个rails项目？ 
https://docs.docker.com/v17.09/compose/rails/
- 