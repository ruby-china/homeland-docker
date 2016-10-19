Ruby China Docker
-----------------

## Configuration

你可以根据需要，修改 `ruby-china/config` 和 `ruby-china/etc` 里面的配置文件。

修改 app.env 增加 `secret_key_base` 涉及应用安装，请注意保密。

```bash
$ openssl rand -hex 32
dd2f6bef6ea70ff3d6aae6601aaa619be6808b343e3bba3b0ed18ae529dc223c
```

## Commands

编译（修改配置、更新 Git 代码）都需要重新编译

```bash
./bin/rebuild
```

启动

```bash
./bin/start
```

重启

```bash
./bin/restart
```

停止

```bash
./bin/stop
```

查看状态

```bash
./bin/status
```