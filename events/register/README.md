Описание блоков:

-   **/users (get)** - получение списка пользователей компании

    ```json - response
    {
        "response": "success",
        "data": {
            "items": [
                {
                    "id": 1,
                    "name": "Пархоменко Алина Петровна",
                    "mail": "guzel-skvazhina@gazprom-neft.ru",
                    "avatar": "https://avatar.gpg"
                }
            ]
        }
    }
    ```

-   **/events (post)** - создание мероприятия

    ```json - request
    {
        "name": "Ежегодная встреча Функций",
        "description": "Встреча с лидерами производственных функций.",
        "header": "Ежегодное встреча посвященная итогам деятельности ключевых направлений.",
        "footer": "Возможны изменения в дате и месте проведения события. Следите за новостями.",
        "additional": "",
        "contacts": ["guzel-skvazhina@gazprom-neft.ru", "guzel-skvazhina@gazprom-neft.ru"],
        "date": "28.01.2026",
        "recordingIntervals": [
            {
                "start": "13:00",
                "end": "14:00",
                "count": 3
            },
            {
                "start": "14:00",
                "end": "15:00",
                "count": 7
            }
        ],
        "isRepeat": true,
        "availableDays": 2,
        "entriesNumber": 2,
        "isShowSendOption": true,
        "isDefaultSendNotifications": true,
        "isWithoutEmailRegister": true,
        "mailTitle": "Ежегодная встреча Функий",
        "mailBody": "<p>Текст письма в html</p>"
    }
    ```

-   **/events/1 (get)** - получение данных по id мероприятия

    ```json - response
    {
        "response": "success",
        "data": {
            "id": 1,
            "name": "Ежегодная встреча Функций",
            "description": "Встреча с лидерами производственных функций.",
            "header": "Ежегодное встреча посвященная итогам деятельности ключевых направлений.",
            "footer": "Возможны изменения в дате и месте проведения события. Следите за новостями.",
            "additional": "",
            "contacts": ["guzel-skvazhina@gazprom-neft.ru", "guzel-skvazhina@gazprom-neft.ru"],
            "date": "28.01.2026",
            "day": "Четверг",
            "recordingIntervals": [
                {
                    "id": 1,
                    "start": "13:00",
                    "end": "14:00",
                    "count": 3
                },
                {
                    "id": 2,
                    "start": "14:00",
                    "end": "15:00",
                    "count": 7
                }
            ],
            "isRepeat": true,
            "availableDays": 2,
            "entriesNumber": 2,
            "isShowSendOption": true,
            "isDefaultSendNotifications": true,
            "isWithoutEmailRegister": true
        }
    }
    ```

-   **/draft-events (post)** - создание черновика мероприятия (данные будут такими же, как и для `/events`, может, только не будет строгой проверки полей)

-   **/external-users (post)** - запрос на получение данных по внешнему пользователю (скорее всего реализовать вообще не получится)

    ```json - request
    {
        "mail": "ivanov@gmail.com"
    }
    ```

    ```json - response
    {
        "response": "success",
        "data": {
            "name": "Иванов Иван Иванович"
        }
    }
    ```

-   **/events-users (post)** - запись на мероприятие

    ```json - request
    {
        "companyEmployees": ["Parkhomenko.AP@gazprom-neft.ru", "Parkhomenko.AP@gazprom-neft.ru"],
        "notCompanyEmployees": ["Parkhomenko.AP@gazprom-neft.ru", "Parkhomenko.AP@gazprom-neft.ru"],
        "intervalId": 1,
        "isSendEmail": true
    }
    ```

    ```json - response
    {
        "response": "success",
        "data": {
            "text": "Вы успешно записались на мероприятие"
        }
    }
    ```
