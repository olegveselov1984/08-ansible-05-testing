# Домашнее задание к занятию 5 «Тестирование roles»

## Подготовка к выполнению

1. Установите molecule и его драйвера: `pip3 install "molecule molecule_docker molecule_podman`.
2. Выполните `docker pull aragast/netology:latest` —  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри.

## Основная часть

Ваша цель — настроить тестирование ваших ролей. 

Задача — сделать сценарии тестирования для vector. 

Ожидаемый результат — все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s ubuntu_xenial` (или с любым другим сценарием, не имеет значения) внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками или не отработать вовсе, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу И из чего может состоять сценарий тестирования.

![image](https://github.com/user-attachments/assets/6b8a7c57-94b5-4cf9-96aa-8547c87ccac7)


2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.

![image](https://github.com/user-attachments/assets/7e0969df-49ac-4680-a987-585a452e5582)


3. Добавьте несколько разных дистрибутивов (oraclelinux:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.

Исправил ошибки в файле main.yaml
![image](https://github.com/user-attachments/assets/fe233337-ef32-4508-8e08-fc1c5785203e)

![image](https://github.com/user-attachments/assets/d106437a-37e5-4700-83a8-8b5aaf01461f)


4. Добавьте несколько assert в verify.yml-файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.).

![image](https://github.com/user-attachments/assets/941eb119-9376-4efb-a68e-ce9cbf1b9f45)

5. Запустите тестирование роли повторно и проверьте, что оно прошло успешно.

![image](https://github.com/user-attachments/assets/8d026fac-f423-4813-97b8-949525a6aaa7)


5. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

https://github.com/olegveselov1984/08-ansible-05-testing/releases/tag/v1.0.2
   

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example).
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.

(venv) ubuntu@ubuntu:~/src/ansible/08-ansible-05-testing/vector-role$ docker run --privileged=True -v /home/ubuntu/src/ansible/08-ansible-05-testing/vector-role:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash

3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
![image](https://github.com/user-attachments/assets/78de3b10-e01f-4d89-8336-5c85cb4d29d6)



4. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.

sudo molecule init scenario tox  --driver-name=podman

![image](https://github.com/user-attachments/assets/21607d0c-23f4-42ab-88df-b75ccf9d7e11)


![image](https://github.com/user-attachments/assets/8a53196a-7b54-45db-89c4-32bfede94e4d)


![image](https://github.com/user-attachments/assets/1a63c600-426b-4166-8e9a-294220f79bbc)



pip3 install selinux ansible-lint==5.1.3 yamllint==1.26.3 lxml molecule==3.4.0 molecule_podman jmespath


5. Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий.

![image](https://github.com/user-attachments/assets/2a302701-c296-411b-a21b-88e46dca32bb)


8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

https://github.com/olegveselov1984/08-ansible-05-testing/releases/tag/v1.0.0


После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Не забудьте указать в ответе теги решений Tox и Molecule заданий. В качестве решения пришлите ссылку на  ваш репозиторий и скриншоты этапов выполнения задания. 

## Необязательная часть

1. Проделайте схожие манипуляции для создания роли LightHouse.
2. Создайте сценарий внутри любой из своих ролей, который умеет поднимать весь стек при помощи всех ролей.
3. Убедитесь в работоспособности своего стека. Создайте отдельный verify.yml, который будет проверять работоспособность интеграции всех инструментов между ними.
4. Выложите свои roles в репозитории.

В качестве решения пришлите ссылки и скриншоты этапов выполнения задания.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.
