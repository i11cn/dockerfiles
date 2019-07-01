# doclever
DOClever的Dockerfile

## Introduce
内部侦听端口为10000，不可更改，内部上传文件保存目录为`/DOClever/upload`，不可更改，不过端口和目录都已经导出，可以在外部挂载，具体方式参看后面的Usage。但是注意，数据库连接并没有设置，由于DOClever的原因，这个参数必须制定，因此需要通过Usage中的三种方式来传给容器内。

## Usage

### Option 1
直接在docker命令行中增加mongodb的参数
```docker run i11cn/doclever:6.2.0 --db mongodb://user:password@host:27017/dbname```

### Option 2
通过docker-compose启动
```
version: '3.6'

services:
  doclever:
    image: i11cn/doclever:6.2.0
    restart: always
    ports:
    - '10000:10000'
    command: --db mongodb://user:password@host:27017/dbname
```

### Option 3
直接挂载配置文件，例如有如下配置文件config.json:
```
{"db":"mongodb://user:password@host:27017/dbname", "filePath":"随意写", "port":10000}
```
然后用命令行`docker run -v config.json:/DOClever-6.2.0/config.json i11cn/doclever:6.2.0`来启动。  
据测试，filePath和port不写，启动会出错，但是确实是没有用到，因为命令行里会覆盖这俩参数，因此可以随意填写。
