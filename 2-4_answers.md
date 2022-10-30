1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea

полный хеш: aefead2207ef7e2aa5dc81a34aedf0cad4c32545
комментарий: Update CHANGELOG.md

как искал:
PS C:\Netology\clone\terraform> git log -1 aefea
commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Thu Jun 18 10:29:58 2020 -0400

    Update CHANGELOG.md

2. Какому тегу соответствует коммит 85024d3?

tag: v0.12.23

как искал:
PS C:\Netology\clone\terraform> git log -1 --oneline 85024d3
85024d3100 (tag: v0.12.23) v0.12.23

3. Сколько родителей у коммита b8d720? Напишите их хеши

родителей 2: 9ea88f22fc6269854151c571162c5bcf958bee2b и 56cd7859e05c36c06b56d013b55a252d0bb7e158

как искал:
PS C:\Netology\clone\terraform> git log --pretty=format:'%h %P' -1 b8d720
b8d720f834 56cd7859e05c36c06b56d013b55a252d0bb7e158 9ea88f22fc6269854151c571162c5bcf958bee2b

4. Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.

как искал:
PS C:\Netology\clone\terraform> git log --pretty=format:'%H %s' --graph v0.12.23..v0.12.24
* 33ff1c03bb960b332be3af2e333462dde88b279e v0.12.24
* b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links
* 3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md
* 6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable
* 5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location
* 06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.md
* d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows
* 4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md
* dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md
* 225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release

5. Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточия перечислены аргументы).

В каком создана: 8c928e8358

как искал:
PS C:\Netology\clone\terraform> git log -S'func providerSource' --oneline --reverse --all
8c928e8358 main: Consult local directories as potential mirrors of providers
5af1e6234a main: Honor explicit provider_installation CLI config when present

для проверки:
git log 8c928e8358 --oneline -p -S'func providerSource'

6. Найдите все коммиты в которых была изменена функция globalPluginDirs

коммиты: 8364383c35, 66ebff90cd, 41ab0aef7a, 52dbf94834, 78b1220558

как искал:
 определяем имя файла с функцией - git grep "globalPluginDirs"
 ищем изменения в функции в файле из первой выборки - git log -L:globalPluginDirs:plugins.go --oneline

7. Кто автор функции synchronizedWriters?

автор: Martin Atkins

как искал:
PS C:\Netology\clone\terraform> git log -S'func synchronizedWriters' --pretty=format:'%h - %an %ae'
bdfea50cc8 - James Bardin j.bardin@gmail.com
5ac311e2a9 - Martin Atkins mart@degeneration.co.uk
