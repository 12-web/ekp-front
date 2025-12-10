## 1.1 ЗАПРОС

### /o/event-registration-api/users/\_search (post) - получение списка пользователей компании

```json
{
    "request": {
        "method": "POST",
        "timestamp": "2025-12-05T10:30:00Z"
    },
    "data": {
        "search": {
            "query": "ива"
        }
    },
    "context": {
        "companyId": 20097,
        "siteId": 20121,
        "currentUserId": 38201
    },
    "pagination": {
        "usersLimit": 20
    }
}
```

## 1.2 ОТВЕТ

```json
{
    "data": {
        "items": [
            {
                "firstName": "Артем",
                "lastName": "Иванов",
                "portraitUrl": "/image/user_portrait?img_id=0&img_id_token=mJAewnLtkSueEU3%2B6k55kaoMN4U%3D&t=1765177166452",
                "fullName": "Артем Иванович Иванов",
                "middleName": "Иванович",
                "position": "Сотрудник",
                "userId": "45137",
                "email": "artiv@gmail.com"
            },
            {
                "firstName": "Иван",
                "lastName": "Иванов",
                "portraitUrl": "/image/user_portrait?img_id=0&img_id_token=eMY%2BfbBvLxKbB1cmFEOUVFicbLk%3D&t=1765177166452",
                "fullName": "Иван Петрович Иванов",
                "middleName": "Петрович",
                "position": "Сотрудник",
                "userId": "45128",
                "email": "ivape@gmail.com"
            },
            {
                "firstName": "Иван",
                "lastName": "Иванов",
                "portraitUrl": "/image/user_portrait?img_id=0&img_id_token=eMY%2BfbBvLxKbB1cmFEOUVFicbLk%3D&t=1765177166452",
                "fullName": "Иван Петрович Иванов",
                "middleName": "Петрович",
                "position": "Сотрудник",
                "userId": "45128",
                "email": "ivape@gmail.com"
            }
        ]
    },
    "response": {
        "status": "success",
        "timestamp": "2025-12-08T06:59:26.445476800Z"
    }
}
```

## 2.1 ЗАПРОС

### /o/event-registration-api/events/\_create (post) - создание мероприятия

```json
{
    "request": {
        "method": "POST",
        "timestamp": "2024-01-15T12:00:00Z"
    },
    "data": {
        "name": "Ежегодная встреча грачей",
        "description": "Встреча с лидерами производственных функций.",
        "header": "Ежегодное встреча посвященная итогам деятельности ключевых направлений.",
        "footer": "Возможны изменения в дате и месте проведения события. Следите за новостями.",
        "additional": "",
        "contacts": ["artiv@gmail.com", "nick@gmail.com"],
        "date": "28.01.2026",
        "day": "Четверг",
        "recordingIntervals": [
            {
                //"id" : 1
                "start": "13:00",
                "end": "14:00",
                "count": 3
            },
            {
                //"id" : 2
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
    },
    "context": {
        "companyId": "20097",
        "currentUserId": "38201",
        "siteId": "20121"
    }
}
```

## 2.2 ОТВЕТ

```json

{
   "response": {
       "code": 200,
       "articleId": 45340,
       "message": "SUCCESS! Registration event with articleId = 45340 was successfully created",
       "status": "success",
       "timestamp": "2025-12-08T06:58:24.616853900Z"
   }
}

// error
{
   "response": {
       "code": 200,
       "message": "ERROR! Registration event article already exists",
       "status": "error",
       "timestamp": "2025-12-10T05:03:49.004491300Z"
   }
}

```

## 3.1 ЗАПРОС

### /o/event-registration-api/events/\_register (post) - запись на мероприятие

```json
{
    "request": {
        "method": "POST",
        "timestamp": "2024-01-15T12:00:00Z"
    },
    "data": {
        "eventId": "46746", // i added it here since it's signinficant
        "companyEmployees": [45128],
        "notCompanyEmployees": [
            "Parkhomenko.AP@gazprom-neft.ru",
            "Parkhomenko.AP@gazprom-neft.ru",
            "Parkhomenko.AP@gazprom-neft.ru"
        ],
        "intervalId": 22,
        "isSendEmail": true
    },
    "context": {
        "companyId": "20097",
        "currentUserId": "45145",
        "siteId": "20121"
    }
}
```

## 3.2 ОТВЕТ

```json

{
    "response": {
        "eventId": "46903",
        "code": 200,
        "count": 3,
        "message": "Updated interval 22, count = 3",
        "userId": "45145",
        "status": "success",
        "timestamp": "2025-12-10T05:06:32.016377600Z"
    }
}

// error
{
    "response": {
        "eventId": "0",
        "code": 200,
        "count": 0,
        "message": "User with id 45145 is already registered to event with id 46903",
        "userId": "0",
        "status": "error",
        "timestamp": "2025-12-10T05:10:54.840891600Z"
    }
}
```

## 4.1 ЗАПРОС

### /o/event-registration-api/certain-event (POST) - получение данных по id мероприятия

```json
{
    "request": {
        "method": "POST",
        "timestamp": "2024-01-15T12:00:00Z"
    },
    "data": {
        "eventId": 45760
    },
    "context": {
        "companyId": "20097",
        "currentUserId": "38201",
        "siteId": "20121"
    }
}
```

## 4.2 ОТВЕТ

```json
{
    "data": {
        "date": "28.01.2026",
        "eventId": "46939",
        "isWithoutEmailRegister": true,
        "footer": "Возможны изменения в дате и месте проведения события. Следите за новостями.",
        "additional": "Возможны изменения в дате и месте проведения события. Следите за новостями.",
        "isShowSendOption": true,
        "description": "Встреча с лидерами производственных функций.",
        "isDefaultSendNotifications": true,
        "recordingIntervals": [
            {
                "count": 3,
                "start": "13:00",
                "intervalId": 0,
                "end": "14:00"
            },
            {
                "count": 7,
                "start": "14:00",
                "intervalId": 0,
                "end": "15:00"
            }
        ],
        "entriesNumber": 2,
        "name": "Ежегодная встреча теней",
        "header": "Ежегодное встреча посвященная итогам деятельности ключевых направлений.",
        "isRepeat": true,
        "day": "Четверг",
        "availableDays": 2,
        "contacts": [
            [
                {
                    "JSONObject": {
                        "firstName": "Николай",
                        "lastName": "Николаев",
                        "portraitUrl": "/image/user_portrait?img_id=38365&img_id_token=Sv1FWbMDvzwyrVxxSP%2B46w0nHu4%3D&t=1765352168061",
                        "fullName": "Николай Николаевич Николаев",
                        "middleName": "Николаевич",
                        "position": "Ответственный за сайт",
                        "userId": "38346",
                        "email": "nick@gmail.com"
                    }
                },
                {
                    "JSONObject": {
                        "firstName": "Питер",
                        "lastName": "Паркер",
                        "portraitUrl": "/image/user_portrait?img_id=0&img_id_token=2WsoBp8VOTxQd%2BLVv%2BBtpqVQFVk%3D&t=1765352168062",
                        "fullName": "Питер Николаевич Паркер",
                        "middleName": "Николаевич",
                        "position": "",
                        "userId": "38369",
                        "email": "spider_man@gmail.com"
                    }
                }
            ]
        ]
    },
    "response": {
        "code": 200,
        "message": "Event successfully found",
        "status": "success",
        "timestamp": "2025-12-10T07:41:08.683420900Z"
    },
    "context": {
        "companyId": "20097",
        "currentUserId": "38201",
        "siteId": "20121"
    }
}

// error
{
    "response": {
        "code": 200,
        "message": "There is no web-content with such eventId: 2",
        "status": "error",
        "timestamp": "2025-12-10T05:01:34.879518600Z"
    }
}
```

## 6.1 ЗАПРОС для получения всех статей на фронт

### POST /o/event-registration-api/events/all

```json
{
    "request": {
        "method": "POST",
        "timestamp": "2024-01-15T12:00:00Z"
    },
    "context": {
        "companyId": "20097",
        "currentUserId": "38201",
        "siteId": "20121"
    }
}
```

## 6.2 ОТВЕТ

// it must be simple response with all necessary info such as
eventId, name, data, timestamp (creation date)

```json
{
    "response": {
        "status": "success",
        "timestamp": "2024-01-15T12:00:01Z"
    },
    "data": {
        "items": [
            {
                "eventId": 1234,
                "name": "Ежегодная встреча Функций",
                "date": "28.01.2026"
            },
            {
                "eventId": 2345,
                "name": "Ежегодная встреча Коллег",
                "date": "28.01.2026"
            }
        ]
    },
    "context": {
        "companyId": "20097",
        "currentUserId": "38201",
        "siteId": "20121"
    }
}
```
