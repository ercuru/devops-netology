### Что делает playbook

- Плейбук разворачивает ClickHouse и Vector на два уже запущенных хоста развернутых на Centos 7

### Какие у него есть параметры 

- IP хостов нужно задать в файле inventory - inventory/prod.yml
- Версии устанавливаемых ПО задаются в group_vars/clickhous/var.yml и group_vars/vector/vector.yml