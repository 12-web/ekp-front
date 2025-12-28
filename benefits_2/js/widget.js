(function () {
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

        _getDefaultContext() {
            if (!EVENT_CONFIG) return {};

            return {
                siteId: EVENT_CONFIG?.siteId || "",
                companyId: EVENT_CONFIG?.companyId || "",
                currentUserId: EVENT_CONFIG?.currentUserId || "",
            };
        }

        _getDefaultParams() {
            return {
                request: {
                    method: "POST",
                    timestamp: new Date().toISOString(),
                },
                context: this._getDefaultContext(),
            };
        }
    }

    class BenefitApi extends BaseApi {
        constructor(props) {
            super(props);
        }

        applyBenefit(data) {
            return this._request("/selection/export", {
                method: "POST",
                headers: this._headers,
                body: JSON.stringify({
                    data,
                    ...this._getDefaultParams(),
                }),
            });
        }

        refuseBenefit(data) {
            return this._request("/selection/export", {
                method: "POST",
                headers: this._headers,
                body: JSON.stringify({
                    data,
                    ...this._getDefaultParams(),
                }),
            });
        }
    }

    class FormApi extends BaseApi {
        constructor(props) {
            super(props);
        }

        getFormData(formId) {
            return this._request(`/${formId}`, {
                headers: this._headers,
            });
        }
    }

    class BenefitForm {
        constructor(applyBtn, refuseBtn) {
            this._applyBtn = applyBtn;
            this._refuseBtn = refuseBtn;
            this._formId = Number(document.querySelector("[data-benefits-id]")?.dataset.benefitsId);

            this._form = document.querySelector("form[data-ddmforminstanceid='10884988']");

            this._fieldsName = {
                food: {
                    label: "Оплата питания",
                    field: "paymentFood",
                },
                vacation: {
                    label: "Выплата на оздоровление к отпуску",
                    field: "payout",
                },
                name: {
                    label: "ФИО",
                    field: "fullName",
                },
                phone: {
                    label: "Номер телефона",
                    field: "phoneNumber",
                },
                company: {
                    label: "Компания",
                    field: "company",
                },
                department: {
                    label: "Подразделения",
                    field: "department",
                },
                bank: {
                    label: "Отделения банка",
                    field: "bankBranch",
                },
                work: {
                    label: "Должность",
                    field: "position",
                },
                date: {
                    label: "Дата",
                    field: "date",
                },
            };

            this._formApi = new FormApi({
                headers: {
                    "X-CSRF-Token": Liferay.authToken,
                },
                baseUrl: "/o/headless-form/v1.0/forms",
            });

            this._api = new BenefitApi({
                headers: {
                    "Content-Type": "application/json",
                },
                baseUrl: EVENT_CONFIG?.baseURL || "/o/benefits",
            });

            this._onApplyClick = this._onApplyClick.bind(this);
            this._onRefuseClick = this._onRefuseClick.bind(this);

            this._applyBtn?.addEventListener("click", this._onApplyClick);
            this._refuseBtn?.addEventListener("click", this._onRefuseClick);
        }

        async _getFormData() {
            try {
                const res = await this._formApi.getFormData(this._formId);

                return res?.structure?.formPages[0]?.formFields?.filter((field) => {
                    return Object.values(this._fieldsName).some((fieldName) =>
                        field?.label?.includes(fieldName.label)
                    );
                });
            } catch (err) {}
        }

        _getSelectResponse(dataFields, fieldName, fieldResponse) {
            if (!dataFields || !fieldName || !fieldResponse) return;

            const response = dataFields
                ?.find((field) => field.label === fieldName)
                ?.formFieldOptions?.find((opt) => opt.value === fieldResponse);
            return response?.label;
        }

        _getRadioResponse(dataFields, fieldName, fieldResponse) {
            if (!dataFields || !fieldName || !fieldResponse) return;

            const response = dataFields
                ?.find((field) => this._checkIncludesString(field.label, fieldName))
                ?.formFieldOptions?.find((opt) => opt.value === fieldResponse);
            return response?.label === "Перевести в гибкие льготы";
        }

        _getInputName(label) {
            if (!label) return;

            return Object.values(this._fieldsName)?.find((fieldName) =>
                this._checkIncludesString(label, fieldName.label)
            );
        }

        _downloadFile(url) {
            const link = document.createElement("a");
            link.href = url;
            link.setAttribute("target", "_blank");
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }

        _checkIncludesString(first, second) {
            if (!first || !second) return;

            return first.toLowerCase().includes(second.toLowerCase());
        }

        async _prepareRequestFromHTML() {
            const request = {};
            const dataFields = await this._getFormData();

            dataFields?.forEach((field) => {
                const el = document.querySelector(`[data-field-name=${field.name}]`);

                const textInput = el?.querySelector("input");
                if (textInput) {
                    const inputFieldData = this._getInputName(field.label);

                    inputFieldData && (request[inputFieldData.field] = textInput.value);
                }

                if (this._checkIncludesString(field.label, this._fieldsName.food.label)) {
                    const radio = el?.querySelector("input:checked");
                    if (!radio) return;

                    const value = radio.value;

                    request.paymentFood = this._getRadioResponse(
                        dataFields,
                        this._fieldsName.food.label,
                        value
                    );
                }

                if (this._checkIncludesString(field.label, this._fieldsName.vacation.label)) {
                    const radio = el?.querySelector("input:checked");
                    if (!radio) return;

                    const value = radio.value;

                    request.payout = this._getRadioResponse(
                        dataFields,
                        this._fieldsName.vacation.label,
                        value
                    );
                }

                if (this._checkIncludesString(field.label, this._fieldsName.bank.label)) {
                    const selector = el?.querySelector("select");
                    request.bankBranch = this._getSelectResponse(
                        dataFields,
                        this._fieldsName.bank.label,
                        selector.value
                    );
                }
            });

            return request;
        }

        async _onApplyClick(e) {
            e?.preventDefault();
            e?.stopPropagation();

            try {
                const request = await this._prepareRequestFromHTML();

                const res = await this._api.applyBenefit({ ...request, userCancelled: false });
                const fileLink = res?.data?.downloadUrl;

                if (res?.response?.status === "success" && fileLink) {
                    this._downloadFile(fileLink);

                    this._form?.submit();
                }
            } catch (err) {}
        }

        async _onRefuseClick(e) {
            e?.preventDefault();
            e?.stopPropagation();

            try {
                const request = await this._prepareRequestFromHTML();

                const res = await this._api.refuseBenefit({ ...request, userCancelled: true });
                const fileLink = res?.data?.downloadUrl;

                if (res?.response?.status === "success" && fileLink) {
                    this._downloadFile(fileLink);

                    this._form?.submit();
                }
            } catch (err) {}
        }
    }

    const applyBenefitBtn = document.querySelector("[data-confirm-benefit]");
    const refuseBenefitBtn = document.querySelector("[data-refuse-benefit]");

    if (applyBenefitBtn || refuseBenefitBtn) {
        new BenefitForm(applyBenefitBtn, refuseBenefitBtn);
    }
})();
