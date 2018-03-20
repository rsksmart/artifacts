# Migration files
`migration.properties` used for upgrading configuration file between versions.

This must be invoked with:
```
java -cp [jar] co.rsk.cli.config.MigrationTool -i original.config -m migration.properties [-o output.config] [--replace]
```

Browse [wiki](https://github.com/rsksmart/rskj/wiki/Configuration-file-changes-in-Bamboo-Release-0.4.1) for further information
