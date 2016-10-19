Ruby China Docker
-----------------

[Ruby China](https://github.com/ruby-china/ruby-china) 开源项目基于 Docker 的自动化部署方案。

你可以用此项目快速构建一个类似 [Ruby China](https://ruby-china.org) 的社区网站。

## 系统需求

- Linux Server [4 Core CPU, 4G Memory, 50G Disk, 64 位] - _建议 Ubuntu Server 14.04_
- [Docker](https://www.docker.com/), [Docker Compose](https://docs.docker.com/compose/)
- [Aliyun OSS](https://www.aliyun.com/product/oss) 或 [UpYun](https://www.upyun.com) 用于文件存储。

## Usage

### 安装 Docker:

下面的脚本是增对 Ubuntu Server 14.04 设计的，其他版本，请查阅 [Docker 官方的安装文档](https://docker.github.io/engine/installation/linux/)。

```bash
curl -sSL https://git.io/vPypp | bash
```

测试是否安装成功：

```bash
sudo docker info
sudo docker-compose version
```

### 获取 ruby-china-docker 的项目

```bash
git clone https://github.com/ruby-china/ruby-china-docker.git
cd ruby-china-docker/
```

你可以根据你的项目情况，修改 `config` 和 `etc` 里面的配置文件。

### 编译环境

> 前面的脚本安装以后，docker 需要用 `sudo` 来执行，切记！

```bash
sudo ./bin/install
```

### 启动

```bash
sudo ./bin/start
```

## 命令列表

> 在 Linux 环境里面，前面的脚本安装以后，docker，以及一下这些命令需要用 `sudo` 来执行，切记！

| Command | Desc |
|---------|------|
| ./bin/install | 首次安装，创建数据库 |
| ./bin/update | 更新应用程序，重新编译，此方法可以更新最新的 Ruby China 代码 |
| ./bin/start | 启动所有服务，将会自动启动所有的服务 |
| ./bin/stop | 停止所有服务 |
| ./bin/restart | 硬重启服务 |
| ./bin/status | 查看服务状态 |