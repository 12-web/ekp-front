(function() {
    class FormInterceptor {
        constructor() {
            this.initialize();
        }

        initialize() {
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', () => this.initFormInterception());
            } else {
                this.initFormInterception();
            }
        }

        // Ищем форму и отмечаем
        initFormInterception() {
            document.querySelectorAll('form').forEach(form => {                
                if (form.hasAttribute('data-form-intercepted')) return;
                
                form.setAttribute('data-form-intercepted', 'true');
                form.addEventListener('submit', (event) => {
                    this.handleFormSubmit(event, form);
                });
            });
        }

        async handleFormSubmit(event, form) {
            event.preventDefault();
            
            try {
                const jsonData = this.createJsonFromFormData(this.collectFormData(form), form);
                const downloadUrl = await this.sendDataToServer(jsonData);
                
                if (downloadUrl) {
                    this.handleDownload(downloadUrl);
                } else {
                    console.error('Произошла ошибка при обработке данных.');
                }
            } catch {
                console.error('Произошла ошибка при отправке данных.');
            }
        }

        collectFormData(form) {
            const formData = new FormData(form);
            const collectedData = {};

            for (let [key, value] of formData.entries()) {
                if (collectedData[key]) {
                    if (Array.isArray(collectedData[key])) {
                        collectedData[key].push(value);
                    } else {
                        collectedData[key] = [collectedData[key], value];
                    }
                } else {
                    collectedData[key] = value;
                }
            }

            form.querySelectorAll('input, select, textarea').forEach(input => {
                const name = input.name || input.id;
                
                if (name && !formData.has(name)) {
                    let value;
                    // TODO добавить для radio
                    if (input.type === 'checkbox' || input.type === 'radio') {
                        return;
                    } else if (input.tagName === 'SELECT') {
                        value = input.multiple 
                            ? Array.from(input.selectedOptions).map(option => option.value)
                            : input.value;
                    } else {
                        value = input.value;
                    }

                    if (value !== undefined) {
                        collectedData[name] = value;
                    }
                }
            });

            return collectedData;
        }

        getLabelForInput(input, form) {
            const label = form.querySelector(`label[for="${input.id}"]`);
            if (label) return label.textContent.trim();
            
            const parentLabel = input.closest('label');
            if (parentLabel) return parentLabel.textContent.trim();

            for (const lbl of form.querySelectorAll('label')) {
                if (lbl.control === input) return lbl.textContent.trim();
                
                if (input.name && lbl.querySelector(`[name="${input.name}"]`)) {
                    return lbl.textContent.trim();
                }
            }
            
            return null;
        }

        getFieldTypeFromLabel(labelText) {
            const lowerText = labelText.toLowerCase();
            
            if (lowerText.includes('фио')) {
                return 'fullName';
            } else if (lowerText.includes('телефон')) {
                return 'phoneNumber';
            } else if (lowerText.includes('компания')) {
                return 'company';
            } else if (lowerText.includes('подразделение')) {
                return 'department';
            } else if (lowerText.includes('должность')) {
                return 'position';
            } else if (lowerText.includes('банк')) {
                return 'bankBranch';
            } else if (lowerText.includes('дата')) {
                return 'date';
            }
            
            return 'unknown';
        }

        createJsonFromFormData(formData, form) {
            return {
                "data": this.mapFormDataToRequiredStructure(formData, form)
            };
        }
        
        mapFormDataToRequiredStructure(formData, form) {
            const mappedData = {};
            
            if (!form) return formData;

            for (const [key, value] of Object.entries(formData)) {
                let processedValue = value;
                
                if (typeof value === 'string') {
                    const lowerValue = value.toLowerCase();
                    if (lowerValue === 'true' || value === '1' || lowerValue === 'on') {
                        processedValue = true;
                    } else if (lowerValue === 'false' || value === '0' || lowerValue === 'off') {
                        processedValue = false;
                    }
                }

                const inputElements = form.querySelectorAll(`[name="${key}"]`);
                if (inputElements.length > 0) {
                    const inputElement = inputElements[0];
                    const label = this.getLabelForInput(inputElement, form);
                    
                    if (label) {
                        const fieldType = this.getFieldTypeFromLabel(label);
                        const fieldMap = {
                            'fullName': 'fullName',
                            'phoneNumber': 'phoneNumber',
                            'company': 'company',
                            'department': 'department',
                            'position': 'position',
                            'bankBranch': 'bankBranch',
                            'date': 'date'
                        };
                        
                        if (fieldMap[fieldType]) {
                            mappedData[fieldMap[fieldType]] = processedValue;
                        }
                    }
                }
            }
            
            return mappedData;
        }

        async sendDataToServer(jsonData) {
            const api = new BaseApi({
                baseUrl: '/o',
                headers: { 'Content-Type': 'application/json' }
            });
            
            const requestData = {
                ...jsonData,
                ...api._getDefaultParams()
            };
            
            const result = await api._request('/export', {
                method: 'POST',
                headers: api._headers,
                body: JSON.stringify(requestData)
            });
            
            if (result?.data?.downloadUrl) {
                return result.data.downloadUrl;
            } else {
                throw new Error('Сервер вернул некорректный ответ');
            }
        }

        handleDownload(downloadUrl) {
            const link = document.createElement('a');
            link.href = downloadUrl;
            link.style.display = 'none';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    }
    
    new FormInterceptor();
})();

class BaseApi {
   constructor({ headers, baseUrl }) {
       this._baseUrl = baseUrl;
       this._headers = headers;
   }

   _getResponseData(res) {
       if (!res.ok) {
           return Promise.reject(`Ошибка: ${res.status}`);
       }
       return res.json();
   }

   async _request(url, options) {
       return fetch(`${this._baseUrl}${url}`, options).then(this._getResponseData);
   }

   _getDefaultParams() {
       return {
           request: {
               method: "POST",
               timestamp: new Date().toISOString(),
           },
           context: EVENT_CONFIG || {},
       };
   }
}