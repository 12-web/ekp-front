## 1.1 ЗАПРОС

### /o/benefits/selection/export (post) - отправка данных формы для скачивания архива документов

```json
{
  "request": {
    "method": "POST",
    "timestamp": "2025-12-18T16:30:00Z"
  },
  "data": {
    "fullName": "Иванов Иван Иванович",
    "phoneNumber": "+7 (999) 123-45-67",
    "company": "ООО Ромашка",
    "department": "Отдел продаж",
    "position": "Менеджер",
    "bankBranch": "Отделение банка",
    "date": "2025-12-18",
    "paymentFood": true, // true = "перевести на льготы", false = "оставить как есть"
    "payout": false // true = "перевести на льготы", false = "оставить как есть"
  },
  "context": {
    "companyId": "20097",
    "currentUserId": "45145",
    "siteId": "20121"
  }
}
```

## 1.2 ОТВЕТ

```json
{
  "data": {
    "downloadUrl": "https://example.com/files/employee_benefits_20251218.zip"
  },
  "response": {
    "status": "success",
    "timestamp": "2025-12-18T16:30:05.123456Z"
  }
}
```
