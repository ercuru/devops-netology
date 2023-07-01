### Что делает playbook
- Playbook разворачивает ClickHouse, Vector, Lighthouse

### Какие у него есть параметры 
- IP хостов нужно задать в файле inventory - inventory/prod.yml
- Версии устанавливаемых clickhous и vector задаются в group_vars/clickhous/var.yml и group_vars/vector/vector.yml
- IP в файле инвентаризации - prod.yml
- Версия Lighthouse задается - group_vars/lighthouse/lighthouse.yml