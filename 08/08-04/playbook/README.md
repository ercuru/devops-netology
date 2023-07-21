### Что делает playbook
- Playbook разворачивает ClickHouse, Vector и Lighthouse с отображением через Nginx 

### Какие у него есть параметры 
- IP хостов задаются в файле inventory - inventory/prod.yml
- Установка приложений происходит через роли - [clickhouse](https://github.com/AlexeySetevoi/ansible-clickhouse), [vector-role](https://github.com/ercuru/vector-role), [lighthouse-role](https://github.com/ercuru/lighthouse-role)