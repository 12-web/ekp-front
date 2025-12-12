

## 1.1  ЗАПРОС  

###  /o/event-registration-api/users/_search     (post) - получение списка пользователей компании

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
###  /o/event-registration-api/events/_create   (post) - создание мероприятия
```json 

{
    "request": {
        "method": "POST",
        "timestamp": "2024-01-15T12:00:00Z"
    },
    "data": {
        "name": "Ежегодная встреча самней",
        "description": "Встреча с лидерами производственных функций.",
        "header": "Ежегодное встреча посвященная итогам деятельности ключевых направлений.",
        "footer": "Возможны изменения в дате и месте проведения события. Следите за новостями.",
        "additional": "",
        "contacts": [
           38346,38369,11234
        ],
        "date": "28.01.2026",
         "day": "Четверг",
        "recordingIntervals": [
            {   "intervalId" : "11",
                "start": "13:00",
                "end": "14:00",
                "count": 3
            },
            {
                 "intervalId" : "22",
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

## 2.2  ОТВЕТ   
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
 ### /o/event-registration-api/events/_register (post) - запись на мероприятие

 ```json 
{
    "request": {
        "method": "POST",
        "timestamp": "2024-01-15T12:00:00Z"
    },
    "data": {
        "eventId": "47580", // i added it here since it's signinficant
        "companyEmployees": [
           45145,38369
            
        ],
        "notCompanyEmployees": [
           "Ivanov ivan","Abramov Abram"
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
// 1. когда все пользователи зарегестированы
{
    "response": {
        "eventId": "47580",
        "code": 200,
        "count": 14,
        "alreadyRegisteredUsers": [],
        "message": "Successfully registered. Company employees list: [45145, 38369] Not company employees list: [Ivanov ivan, Abramov Abram] List of users registered before: []",
        "userId": "45145",
        "status": "success",
        "timestamp": "2025-12-11T07:10:35.147349300Z"
    }
}
// 2. когда есть уже зарегистрированные пользователи
{
    "response": {
        "eventId": "47580",
        "code": 200,
        "count": 12,
        "alreadyRegisteredUsers": [
            "45145",
            "38369"
        ],
        "message": "Successfully registered. Company employees list: [] Not company employees list: [Ivanov ivan, Abramov Abram] List of users registered before: [45145, 38369]",
        "userId": "45145",
        "status": "success",
        "timestamp": "2025-12-11T07:12:10.926559800Z"
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



## 5.1  ЗАПРОС  для получения всех статей на фронт 
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





## 5.2 ОТВЕТ

// it must be simple response with all necessary  info such as
eventId, name, data, timestamp (creation date)
```json 
{
    "data": {
        "items": [
            {
                "date": "28.01.2026",
                "eventId": "47421",
                "name": "Ежегодная встреча vачей"
            },
            {
                "date": "28.01.2026",
                "eventId": "47500",
                "name": "Ежегодная встреча Sачей"
            },
            {
                "date": "28.01.2026",
                "eventId": "47580",
                "name": "Ежегодная встреча qачей"
            },
            {
                "date": "28.01.2026",
                "eventId": "47642",
                "name": "Ежегодная встреча eачей"
            }
        ]
    },
    "response": {
        "code": 200,
        "message": "SUCCESS",
        "status": "success",
        "timestamp": "2025-12-11T07:05:16.500661Z"
    },
    "context": {
        "companyId": "20097",
        "currentUserId": "38201",
        "siteId": "20121"
    }
}
```

## 6.1  ЗАПРОС  для получения всех событий на который записан кокретный User
### POST /o/event-registration-api/users/find_user_events

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
 ```json 
{
    "data": [
        {
            "isRegisteredByOtherMan": false,
            "registrationCreator": {
                "firstName": "John",
                "lastName": "Lenon",
                "portraitUrl": "/image/user_portrait?img_id=0&img_id_token=bLb7CcvnCHFe2UjSAjwgA%2BxiUOE%3D&t=1765430585288",
                "fullName": "John Lenon",
                "middleName": "",
                "position": "Сотрудник",
                "userId": "45145",
                "email": "jlenon@gmail.com"
            },
            "registeredForEventUser": {
                "firstName": "John",
                "lastName": "Lenon",
                "portraitUrl": "/image/user_portrait?img_id=0&img_id_token=bLb7CcvnCHFe2UjSAjwgA%2BxiUOE%3D&t=1765430585288",
                "fullName": "John Lenon",
                "middleName": "",
                "position": "Сотрудник",
                "userId": "45145",
                "email": "jlenon@gmail.com"
            },
            "event": {
                "date": "28.01.2026",
                "eventId": "47421",
                "isWithoutEmailRegister": true,
                "footer": "Возможны изменения в дате и месте проведения события. Следите за новостями.",
                "additional": "",
                "isShowSendOption": true,
                "description": "Встреча с лидерами производственных функций.",
                "isDefaultSendNotifications": true,
                "recordingIntervals": [
                    {
                        "start": "13:00",
                        "count": 3,
                        "intervalId": 11,
                        "end": "14:00"
                    },
                    {
                        "start": "14:00",
                        "count": 7,
                        "intervalId": 22,
                        "end": "15:00"
                    }
                ],
                "entriesNumber": 2,
                "name": "Ежегодная встреча vачей",
                "header": "Ежегодное встреча посвященная итогам деятельности ключевых направлений.",
                "isRepeat": true,
                "day": "Четверг",
                "availableDays": 2,
                "contacts": [
                    "38346",
                    "38369",
                    "11234"
                ]
            }
        },
        {
            "isRegisteredByOtherMan": true,
            "registrationCreator": {
                "firstName": "Артем",
                "lastName": "Иванов",
                "portraitUrl": "/image/user_portrait?img_id=0&img_id_token=mJAewnLtkSueEU3%2B6k55kaoMN4U%3D&t=1765430585288",
                "fullName": "Артем Иванович Иванов",
                "middleName": "Иванович",
                "position": "Сотрудник",
                "userId": "45137",
                "email": "artiv@gmail.com"
            },
            "registeredForEventUser": {
                "firstName": "John",
                "lastName": "Lenon",
                "portraitUrl": "/image/user_portrait?img_id=0&img_id_token=bLb7CcvnCHFe2UjSAjwgA%2BxiUOE%3D&t=1765430585288",
                "fullName": "John Lenon",
                "middleName": "",
                "position": "Сотрудник",
                "userId": "45145",
                "email": "jlenon@gmail.com"
            },
            "event": {
                "date": "28.01.2026",
                "eventId": "47500",
                "isWithoutEmailRegister": true,
                "footer": "Возможны изменения в дате и месте проведения события. Следите за новостями.",
                "additional": "",
                "isShowSendOption": true,
                "description": "Встреча с лидерами производственных функций.",
                "isDefaultSendNotifications": true,
                "recordingIntervals": [
                    {
                        "start": "13:00",
                        "count": 3,
                        "intervalId": 11,
                        "end": "14:00"
                    },
                    {
                        "start": "14:00",
                        "count": 17,
                        "intervalId": 22,
                        "end": "15:00"
                    }
                ],
                "entriesNumber": 2,
                "name": "Ежегодная встреча Sачей",
                "header": "Ежегодное встреча посвященная итогам деятельности ключевых направлений.",
                "isRepeat": true,
                "day": "Четверг",
                "availableDays": 2,
                "contacts": [
                    "38346",
                    "38369",
                    "11234"
                ]
            }
        },
        {
            "isRegisteredByOtherMan": false,
            "registrationCreator": {
                "firstName": "John",
                "lastName": "Lenon",
                "portraitUrl": "/image/user_portrait?img_id=0&img_id_token=bLb7CcvnCHFe2UjSAjwgA%2BxiUOE%3D&t=1765430585288",
                "fullName": "John Lenon",
                "middleName": "",
                "position": "Сотрудник",
                "userId": "45145",
                "email": "jlenon@gmail.com"
            },
            "registeredForEventUser": {
                "firstName": "John",
                "lastName": "Lenon",
                "portraitUrl": "/image/user_portrait?img_id=0&img_id_token=bLb7CcvnCHFe2UjSAjwgA%2BxiUOE%3D&t=1765430585288",
                "fullName": "John Lenon",
                "middleName": "",
                "position": "Сотрудник",
                "userId": "45145",
                "email": "jlenon@gmail.com"
            },
            "event": {
                "date": "28.01.2026",
                "eventId": "47580",
                "isWithoutEmailRegister": true,
                "footer": "Возможны изменения в дате и месте проведения события. Следите за новостями.",
                "additional": "",
                "isShowSendOption": true,
                "description": "Встреча с лидерами производственных функций.",
                "isDefaultSendNotifications": true,
                "recordingIntervals": [
                    {
                        "start": "13:00",
                        "count": 3,
                        "intervalId": 11,
                        "end": "14:00"
                    },
                    {
                        "start": "14:00",
                        "count": 18,
                        "intervalId": 22,
                        "end": "15:00"
                    }
                ],
                "entriesNumber": 2,
                "name": "Ежегодная встреча qачей",
                "header": "Ежегодное встреча посвященная итогам деятельности ключевых направлений.",
                "isRepeat": true,
                "day": "Четверг",
                "availableDays": 2,
                "contacts": [
                    "38346",
                    "38369",
                    "11234"
                ]
            }
        }
    ],
    "response": {
        "code": "success",
        "message": "SUCCESS",
        "status": "success",
        "timestamp": "2025-12-11T05:43:40.116745800Z"
    },
    "context": {
        "companyId": "20097",
        "currentUserId": "45145",
        "siteId": "20121"
    }
}

```

## 7.1  ЗАПРОС  для отмены мероприятия для конеретного пользователя
### POST /o/event-registration-api/_cancel_event
```json 
{
    "request": {
        "method": "POST",
        "timestamp": "2024-01-15T12:00:00Z"
    },
    "data": {
        "eventId": 47580
    },
    "context": {
        "companyId": "20097",
        "currentUserId": "45145",
        "siteId": "20121"
    }
}
```

## 7.2 ОТВЕТ  для отмены мероприятия для конеретного пользователя
```json 

{
    "response": {
        "success": true,
        "deletedCount": 1,
        "intervalId": 22,
        "usersRemoved": [
            45145
        ],
        "message": "successfully cancelled"
    }
}

// error
{
    "response": {
        "code": 404,
        "message": "Event registration for user with id 45145 not found",
        "status": "error",
        "timestamp": "2025-12-11T06:58:21.200594400Z"
    }
}