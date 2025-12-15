## 1.1 ЗАПРОС

### /friday/user (post) - получение данных пользователя

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
        "isRegistered": false,
        "couple": null
    },
    "response": {
        "status": "success",
        "timestamp": "2025-12-08T06:59:26.445476800Z"
    }
}
```

## 1.3 ОТВЕТ

```json - зарегистрирован и нет пары
{
    "data": {
        "isRegistered": true,
        "interests": "Мои интересы",
        "couple": null
    },
    "response": {
        "status": "success",
        "timestamp": "2025-12-08T06:59:26.445476800Z"
    }
}
```

## 1.4 ОТВЕТ

```json - зарегистрирован и есть пара
{
    "data": {
        "isRegistered": true,
        "interests": "Мои интересы",
        "couple": {
            "interests": "Летом люблю кататься на велосипеде, зимой занимаюсь сноубордом. Работаю дизайнером и очень хочу найти настоящих друзей.",
            "firstName": "Иван",
            "lastName": "Иванов",
            "portraitUrl": "/image/user_portrait?img_id=0&img_id_token=mJAewnLtkSueEU3%2B6k55kaoMN4U%3D&t=1765177166452",
            "fullName": "Артем Иванович Иванов",
            "middleName": "Иванович",
            "position": "Сотрудник",
            "userId": "45137",
            "email": "artiv@gmail.com"
        }
    },
    "response": {
        "status": "success",
        "timestamp": "2025-12-08T06:59:26.445476800Z"
    }
}
```

## 2.1 ЗАПРОС

### /friday/register (post) - регистрация пользователя

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

## 2.2 ОТВЕТ

```json
{
    "response": {
        "status": "success",
        "timestamp": "2025-12-08T06:59:26.445476800Z"
    }
}
```

## 3.1 ЗАПРОС

### /friday/user/update (post) - изменение данных пользователя

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
        "status": "success",
        "timestamp": "2025-12-08T06:59:26.445476800Z"
    }
}
```

## 4.1 ЗАПРОС

### /friday/unregister (post) - отписаться от участия

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

## 4.2 ОТВЕТ

```json
{
    "response": {
        "status": "success",
        "timestamp": "2025-12-08T06:59:26.445476800Z"
    }
}
```
