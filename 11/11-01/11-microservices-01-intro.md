# Домашнее задание к занятию «Введение в микросервисы»

## Задача
>
>Руководство крупного интернет-магазина, у которого постоянно растёт пользовательская база и количество заказов, рассматривает возможность переделки своей внутренней   ИТ-системы на основе микросервисов. 
>
>Вас пригласили в качестве консультанта для оценки целесообразности перехода на микросервисную архитектуру. 
>
>Опишите, какие выгоды может получить компания от перехода на микросервисную архитектуру и какие проблемы нужно решить в первую очередь.

## Решение

**Выгоды:**
- повышение устойчивости к ошибкам, за счет разделения на отдельные микросервисы 
- ускорение вывод нововведений за счёт возможности параллельной разработки отдельных сервисов и их быстрого внедрения
- масштабируемость, из-за возможности более гибко распределять вычислительные ресурсы на конкретные в данный момент сервисы
- экономия на "мощностях" при масштабировании, т.к. добавлять ресурсы нужно только конкретным сервисам 

**Проблемы, которые нужно решить в первую очередь:**
- оценить на сколько выгоды от перехода на микросервисную архитектуру превышают сложность её внедрения
- определить чёткую структуру организации
- понять, какую часть монолита нужно разбивать на микросервисы, а какую нет
- изменение системы мониторинга под новую микросервисную архитектуру
