# Домашнее задание к занятию 9 «Процессы CI/CD»


<details>
  <summary>Подготовка к выполнению</summary>

>1. Создайте два VM в Yandex Cloud с параметрами: 2CPU 4RAM Centos7 (остальное по минимальным требованиям).
>2. Пропишите в [inventory](./infrastructure/inventory/cicd/hosts.yml) [playbook](./infrastructure/site.yml) созданные хосты.
>3. Добавьте в [files](./infrastructure/files/) файл со своим публичным ключом (id_rsa.pub). Если ключ называется иначе — найдите таску в плейбуке, которая использует id_rsa.pub имя, и исправьте на своё.
>4. Запустите playbook, ожидайте успешного завершения.
>5. Проверьте готовность SonarQube через [браузер](http://localhost:9000).
>6. Зайдите под admin\admin, поменяйте пароль на свой.
>7.  Проверьте готовность Nexus через [бразуер](http://localhost:8081).
>8. Подключитесь под admin\admin123, поменяйте пароль, сохраните анонимный доступ.

<p align="center">
  <img  src=".//scr/1.jpg"><img  src=".//scr/2.jpg"><img  src=".//scr/3.jpg"><img  src=".//scr/4.jpg">
</p>

</details>

## Знакомоство с SonarQube

### Основная часть

>1. Создайте новый проект, название произвольное.
>2. Скачайте пакет sonar-scanner, который вам предлагает скачать SonarQube.
>3. Сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ).
>6. Проверьте `sonar-scanner --version`.

```shell
$ sonar-scanner --version
INFO: Scanner configuration file: /home/andrey/sonar/conf/sonar-scanner.properties
INFO: Project root configuration file: NONE
INFO: SonarScanner 4.8.0.2856
INFO: Java 11.0.17 Eclipse Adoptium (64-bit)
INFO: Linux 5.15.0-76-generic amd64
```

>5. Запустите анализатор против кода из директории [example](./example) с дополнительным ключом `-Dsonar.coverage.exclusions=fail.py`.
>6. Посмотрите результат в интерфейсе.

<p align="center">
  <img  src=".//scr/5.jpg">
</p>

>7. Исправьте ошибки, которые он выявил, включая warnings.
>8. Запустите анализатор повторно — проверьте, что QG пройдены успешно.
>9. Сделайте скриншот успешного прохождения анализа, приложите к решению ДЗ.

<p align="center">
  <img  src=".//scr/6.jpg">
</p>

## Знакомство с Nexus

### Основная часть

>1. В репозиторий `maven-public` загрузите артефакт с GAV-параметрами:
>
> *    groupId: netology;
> *    artifactId: java;
> *    version: 8_282;
> *    classifier: distrib;
> *    type: tar.gz.
>   
>2. В него же загрузите такой же артефакт, но с version: 8_102.
>3. Проверьте, что все файлы загрузились успешно.
>4. В ответе пришлите файл `maven-metadata.xml` для этого артефекта.

Файл [maven-metadata.xml](https://github.com/ercuru/devops-netology/blob/main/09/09-03/maven-metadata.xml)

### Знакомство с Maven

<details>
  <summary>Подготовка к выполнению</summary>

>1. Скачайте дистрибутив с [maven](https://maven.apache.org/download.cgi).
>2. Разархивируйте, сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ).
>3. Удалите из `apache-maven-<version>/conf/settings.xml` упоминание о правиле, отвергающем HTTP- соединение — раздел mirrors —> id: my-repository-http-unblocker.
>4. Проверьте `mvn --version`.

```shell
$ mvn --version
Apache Maven 3.9.3 (21122926829f1ead511c958d89bd2f672198ae9f)
Maven home: /home/andrey/apache-maven-3.9.3
Java version: 1.8.0_362, vendor: Private Build, runtime: /usr/lib/jvm/java-8-openjdk-amd64/jre
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "5.15.0-78-generic", arch: "amd64", family: "unix"
```

>5. Заберите директорию [mvn](./mvn) с pom.

</details>



### Основная часть

>1. Поменяйте в `pom.xml` блок с зависимостями под ваш артефакт из первого пункта задания для Nexus (java с версией 8_282).
>2. Запустите команду `mvn package` в директории с `pom.xml`, ожидайте успешного окончания.

```shell
$ mvn package
[INFO] Scanning for projects...
[INFO]
[INFO] --------------------< com.netology.app:simple-app >---------------------
[INFO] Building simple-app 1.0-SNAPSHOT
[INFO]   from pom.xml
[INFO] --------------------------------[ jar ]---------------------------------
Downloading from my-repo: http://51.250.22.25:8081/repository/maven-public/netology/java/8_282/java-8_282.pom
[WARNING] The POM for netology:java:tar.gz:distrib:8_282 is missing, no dependency information available
Downloading from my-repo: http://51.250.22.25:8081/repository/maven-public/netology/java/8_282/java-8_282-distrib.tar.gz
Downloaded from my-repo: http://51.250.22.25:8081/repository/maven-public/netology/java/8_282/java-8_282-distrib.tar.gz (41 kB at 471 kB/s)
[INFO]
[INFO] --- resources:3.3.1:resources (default-resources) @ simple-app ---
Downloading from central: https://repo.maven.apache.org/maven2/org/codehaus/plexus/plexus-interpolation/1.26/plexus-interpolation-1.26.pom
...
Downloaded from central: https://repo.maven.apache.org/maven2/org/apache/commons/commons-compress/1.21/commons-compress-1.21.jar (1.0 MB at 13 MB/s)
[WARNING] JAR will be empty - no content was marked for inclusion!
[INFO] Building jar: /home/andrey/practise/netology/9_3/mvn/target/simple-app-1.0-SNAPSHOT.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  6.946 s
[INFO] Finished at: 2023-07-30T18:17:49+03:00
[INFO] ------------------------------------------------------------------------
```

>3. Проверьте директорию `~/.m2/repository/`, найдите ваш артефакт.

<p align="center">
  <img  src=".//scr/7.jpg">
</p>

>4. В ответе пришлите исправленный файл `pom.xml`.

Файл [pom.xml](https://github.com/ercuru/devops-netology/blob/main/09/09-03/pom.xml)
