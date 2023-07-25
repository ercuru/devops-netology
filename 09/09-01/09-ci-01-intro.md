# Домашнее задание к занятию 7 «Жизненный цикл ПО»

> ## Подготовка к выполнению
>
>1. Получить бесплатную версию [Jira](https://www.atlassian.com/ru/software/jira/free).
>2. Настроить её для своей команды разработки.
>3. Создать доски Kanban и Scrum.
>4. [Дополнительные инструкции от разработчика Jira](https://support.atlassian.com/jira-cloud-administration/docs/import-and-export-issue-workflows/).
>
>## Основная часть
>
>Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:
>
>1. Open -> On reproduce.
>2. On reproduce -> Open, Done reproduce.
>3. Done reproduce -> On fix.
>4. On fix -> On reproduce, Done fix.
>5. Done fix -> On test.
>6. On test -> On fix, Done.
>7. Done -> Closed, Open.
>
>Остальные задачи должны проходить по упрощённому workflow:
>
>1. Open -> On develop.
>2. On develop -> Open, Done develop.
>3. Done develop -> On test.
>4. On test -> On develop, Done.
>5. Done -> Closed, Open.
>
>**Что нужно сделать**
>
>1. Создайте задачу с типом bug, попытайтесь провести его по всему workflow до Done. 
>1. Создайте задачу с типом epic, к ней привяжите несколько задач с типом task, проведите их по всему workflow до Done. 
>1. При проведении обеих задач по статусам используйте kanban. 
>1. Верните задачи в статус Open.
>1. Перейдите в Scrum, запланируйте новый спринт, состоящий из задач эпика и одного бага, стартуйте спринт, проведите задачи до состояния Closed. Закройте спринт.
>2. Если всё отработалось в рамках ожидания — выгрузите схемы workflow для импорта в XML. Файлы с workflow и скриншоты workflow приложите к решению задания.

## Решение
1. Создаем workflow для Bug

<p align="center">
  <img  src=".//scr/workflow_bug.jpg">
</p>

2. Создаем workflow для всех остальных задач

<p align="center">
  <img  src=".//scr/workflow_other-tasks.jpg">
</p>

3. Создаем задачи с типом Bug и Epic с подзадачами и проводим по созданным workflow на Kanban доске

<p align="center">
  <img  src=".//scr/exp1.jpg">
</p>
<p align="center">
  <img  src=".//scr/exp2.jpg">
</p>

4. Создадим Scrum доску и создадим спринт c нашими задачами

<p align="center">
  <img  src=".//scr/scr_ex1.png">
</p>

<p align="center">
  <img  src=".//scr/scr_ex2.jpg">
</p>

5. Проведем наши задачи по спринту до конца и закроем спринт

<p align="center">
  <img  src=".//scr/scr_ex3.jpg">
</p>

<p align="center">
  <img  src=".//scr/scr_ex4.jpg">
</p>

<p align="center">
  <img  src=".//scr/scr_ex5.jpg">
</p>

Результаты выполнения спринта:

<p align="center">
  <img  src=".//scr/scr_ex6.jpg">
</p>
