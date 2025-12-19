## 1.1 ЗАПРОС

### o/friday/certain_user (post) - получение данных пользователя

```json
{
    "request": {
        "method": "POST",
        "timestamp": "2025-12-05T10:30:00Z"
    },
    "context": {
        "companyId": 20097,
        "siteId": 20121,
        "currentUserId": 38201
    }
}
```

## 1.2 ОТВЕТ

```json - не зарегистрирован
{
    "data": {
        "couple": false,
        "isRegistered": false,
        "interests": "",
        "user": {}
    },
    "response": {
        "status": "success",
        "timestamp": "2025-12-18T14:41:26.118158500Z"
    }
}
```

## 1.3 ОТВЕТ

```json - зарегистрирован и нет пары
{
    "data": {
        "couple": false,
        "isRegistered": true,
        "interests": "Интересы sport",
        "user": {
            "firstName": "Питер",
            "lastName": "Паркер",
            "portraitUrl": "/image/user_portrait?img_id=0&img_id_token=2WsoBp8VOTxQd%2BLVv%2BBtpqVQFVk%3D&t=1766066496330",
            "fullName": "Паркер Питер Николаевич",
            "isRegistered": true,
            "middleName": "Николаевич",
            "position": "",
            "interests": "Интересы sport",
            "userId": "38369",
            "email": "spider_man@gmail.com"
        }
    },
    "response": {
        "status": "success",
        "timestamp": "2025-12-18T14:40:42.736250500Z"
    }
}
```

## 1.4 ОТВЕТ

```json - зарегистрирован и есть пара
{
    "data": {
        "couple": {
            "firstName": "John",
            "lastName": "Lenon",
            "portraitUrl": "/image/user_portrait?img_id=0&img_id_token=bLb7CcvnCHFe2UjSAjwgA%2BxiUOE%3D&t=1766066496330",
            "fullName": "Lenon John ",
            "isRegistered": true,
            "middleName": "",
            "position": "Сотрудник",
            "interests": "Интересы sport",
            "userId": "45145",
            "email": "viktor21kashtanov@gmail.com"
        },
        "isRegistered": true,
        "interests": "Интересы sport",
        "user": {
            "firstName": "Мария",
            "lastName": "Каширина",
            "portraitUrl": "/image/user_portrait?img_id=43347&img_id_token=ezm5kqd12DcOR5lAyJ%2BtBOz6zTs%3D&t=1766066496249",
            "fullName": "Каширина Мария Николаевна",
            "isRegistered": true,
            "middleName": "Николаевна",
            "position": "Сотрудник",
            "interests": "Интересы sport",
            "userId": "38277",
            "email": "baby_girl@gmail.com"
        }
    },
    "response": {
        "status": "success",
        "timestamp": "2025-12-18T14:26:24.121843600Z"
    }
}
```

## 2.1 ЗАПРОС

### o/friday/\_register (post) - регистрация пользователя

```json
{
    "request": {
        "method": "POST",
        "timestamp": "2025-12-05T10:30:00Z"
    },
    "data": {
        "interests": "Интересы sport"
    },
    "context": {
        "companyId": 20097,
        "siteId": 20121,
        "currentUserId": 48901
    }
}
```

## 2.2 ОТВЕТ

```json
{
    "response": {
        "code": 200,
        "message": "User with id 48901 already registered",
        "status": "error",
        "timestamp": "2025-12-17T16:50:10.791194300Z"
    }
}
```

## 2.3 ОТВЕТ

```json
{
    "response": {
        "code": 200,
        "message": "User with id 45153 successfully registered",
        "status": "success",
        "timestamp": "2025-12-17T16:52:44.999133800Z"
    }
}
```

## 3.1 ЗАПРОС

### o/friday/user/update (post) - изменение данных пользователя

```json
{
    "request": {
        "method": "POST",
        "timestamp": "2025-12-05T10:30:00Z"
    },
    "data": {
        "interests": "Интересы пользователя"
    },
    "context": {
        "companyId": 20097,
        "siteId": 20121,
        "currentUserId": 38201
    }
}
```

## 3.2 ОТВЕТ

```json
{
    "response": {
        "code": 200,
        "message": "interests updated",
        "status": "success",
        "timestamp": "2025-12-17T21:20:47.785348500Z"
    }
}
```

## 3.3 ОТВЕТ

```json
{
    "response": {
        "code": 200,
        "message": "Wrong input data",
        "status": "error",
        "timestamp": "2025-12-17T21:19:54.969509100Z"
    }
}
```

## 4.1 ЗАПРОС

### o/friday/\_unregister (post) - отписаться от участия

```json
{
    "request": {
        "method": "POST",
        "timestamp": "2025-12-05T10:30:00Z"
    },
    "context": {
        "companyId": 20097,
        "siteId": 20121,
        "currentUserId": 48901
    }
}
```

## 4.2 ОТВЕТ

```json
{
    "response": {
        "code": 200,
        "message": "User 48901 unregistered. User 38277 moved to reserves",
        "status": "success",
        "timestamp": "2025-12-17T20:49:50.139786Z"
    }
}
```

## 4.3 ОТВЕТ

```json
{
    "response": {
        "code": 200,
        "message": "Unexpected error while unregistering: null",
        "status": "error",
        "timestamp": "2025-12-17T21:22:25.957398700Z"
    }
}
```
