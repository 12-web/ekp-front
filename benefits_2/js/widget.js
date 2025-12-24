const mockFormData = {
    availableLanguages: ["ru-RU"],
    creator: {
        additionalName: "",
        contentType: "UserAccount",
        familyName: "Шемяков",
        givenName: "Данила",
        id: 5057601,
        name: "Шемяков Данила",
        profileURL: "/web/shemyakov.de",
    },
    dateCreated: "2025-10-29T10:39:19Z",
    dateModified: "2025-12-19T07:21:36Z",
    defaultLanguage: "ru_RU",
    description: "\n",
    id: 10666930,
    name: "Форма согласия",
    structure: {
        availableLanguages: ["ru-RU"],
        creator: {
            additionalName: "",
            contentType: "UserAccount",
            familyName: "Шемяков",
            givenName: "Данила",
            id: 5057601,
            name: "Шемяков Данила",
            profileURL: "/web/shemyakov.de",
        },
        dateCreated: "2025-10-29T10:39:19Z",
        dateModified: "2025-12-19T07:21:36Z",
        description: "\n",
        formPages: [
            {
                formFields: [
                    {
                        dataType: "string",
                        displayStyle: "",
                        formFieldOptions: [],
                        hasFormRules: false,
                        immutable: true,
                        inputControl: "paragraph",
                        label: "Стартовый текст",
                        localizable: true,
                        multiple: false,
                        name: "Поле37943214",
                        predefinedValue: "",
                        repeatable: false,
                        required: false,
                        showLabel: true,
                        text: '<div class="clearfix component-paragraph text-break" data-lfr-editable-id="element-text" data-lfr-editable-type="rich-text"><span style="color:#000000; font-size:16px;">При&nbsp;участии&nbsp;в&nbsp;проекте&nbsp;Вы&nbsp;можете&nbsp;выбрать&nbsp;те&nbsp;льготы,&nbsp;которые необходимы&nbsp;именно&nbsp;Вам.<br />\n<br />\nИнформация&nbsp;о&nbsp;проекте&nbsp;«Гибкие&nbsp;льготы»&nbsp;отражена&nbsp;в&nbsp;презентации.&nbsp;Если&nbsp;у&nbsp;Вас&nbsp;остались&nbsp;вопросы,&nbsp;Вы&nbsp;можете&nbsp;отправить&nbsp;их&nbsp;по&nbsp;электронной&nbsp;почте&nbsp;</span><a href="mailto:benefits.zap@gazprom-neft.ru"><span style="color:#000000; font-size: 16px;">benefits.zap@gazprom-neft.ru</span></a><span style="color:#000000;font-size: 16px;">.<br />\n<br />\nПросим Вас выразить свое решение по участию в 3 этапе проекта.<br />\n<br />\nЕсли Вы готовы &nbsp;воспользоваться предложением – нажмите «Согласиться на участие в проекте «Гибкие льготы».<br />\n<br />\nВ случае, если Вы не готовы участвовать в проекте «Гибкие льготы», пожалуйста, нажмите «Отказаться от участия в проекте «Гибкие льготы».</span></div>\n',
                    },
                    {
                        dataType: "string",
                        displayStyle: "",
                        formFieldOptions: [
                            {
                                label: "Оставить как есть, ничего не изменять",
                                value: "Параметр62088148",
                            },
                            {
                                label: "Перевести в гибкие льготы",
                                value: "Параметр31064982",
                            },
                        ],
                        hasFormRules: false,
                        immutable: false,
                        inputControl: "radio",
                        label: "Выберите опцию для льготы “Оплата питания” *",
                        localizable: true,
                        multiple: false,
                        name: "Поле21985454",
                        predefinedValue: '["Параметр62088148"]',
                        repeatable: false,
                        required: false,
                        showLabel: true,
                    },
                    {
                        dataType: "string",
                        displayStyle: "",
                        formFieldOptions: [
                            {
                                label: "Оставить как есть, ничего не изменять",
                                value: "Параметр62088148",
                            },
                            {
                                label: "Перевести в гибкие льготы",
                                value: "Параметр31064982",
                            },
                        ],
                        hasFormRules: false,
                        immutable: false,
                        inputControl: "radio",
                        label: "Выберите опцию для льготы “Выплата на оздоровление к отпуску (20 000руб.)”",
                        localizable: true,
                        multiple: false,
                        name: "Поле70642588",
                        predefinedValue: '["Параметр62088148"]',
                        repeatable: false,
                        required: false,
                        showLabel: true,
                    },
                    {
                        dataType: "string",
                        displayStyle: "",
                        formFieldOptions: [],
                        hasFormRules: false,
                        immutable: true,
                        inputControl: "paragraph",
                        label: "",
                        localizable: true,
                        multiple: false,
                        name: "Поле93083727",
                        predefinedValue: "",
                        repeatable: false,
                        required: false,
                        showLabel: true,
                        text: '<h4 class="text-dark"><b style="color:#000000;">2 ШАГ. Персональные данные</b></h4>\n',
                    },
                    {
                        dataType: "string",
                        displayStyle: "singleline",
                        formFieldOptions: [],
                        hasFormRules: false,
                        immutable: false,
                        inputControl: "text",
                        label: "ФИО",
                        localizable: true,
                        multiple: false,
                        name: "Поле27256182",
                        predefinedValue: "",
                        repeatable: false,
                        required: true,
                        showLabel: true,
                    },
                    {
                        dataType: "string",
                        displayStyle: "singleline",
                        formFieldOptions: [],
                        hasFormRules: false,
                        immutable: false,
                        inputControl: "text",
                        label: "Номер телефона",
                        localizable: true,
                        multiple: false,
                        name: "Поле30398955",
                        predefinedValue: "",
                        repeatable: false,
                        required: true,
                        showLabel: true,
                        validation: {
                            errorMessage: "Не более 11 символов",
                        },
                    },
                    {
                        dataType: "string",
                        displayStyle: "singleline",
                        formFieldOptions: [],
                        hasFormRules: false,
                        immutable: false,
                        inputControl: "text",
                        label: "Компания",
                        localizable: true,
                        multiple: false,
                        name: "Поле56099893",
                        predefinedValue: "",
                        repeatable: false,
                        required: true,
                        showLabel: true,
                    },
                    {
                        dataType: "string",
                        displayStyle: "singleline",
                        formFieldOptions: [],
                        hasFormRules: false,
                        immutable: false,
                        inputControl: "text",
                        label: "Подразделения",
                        localizable: true,
                        multiple: false,
                        name: "Поле04690024",
                        predefinedValue: "",
                        repeatable: false,
                        required: true,
                        showLabel: true,
                    },
                    {
                        dataType: "string",
                        displayStyle: "",
                        formFieldOptions: [
                            {
                                label: "Филиал 1",
                                value: "Параметр24255555",
                            },
                            {
                                label: "Филиал 2",
                                value: "Параметр19803899",
                            },
                            {
                                label: "Филиал 3",
                                value: "Параметр24565455",
                            },
                            {
                                label: "Филиал 4",
                                value: "Параметр55203748",
                            },
                            {
                                label: "Филиал 5",
                                value: "Параметр58287229",
                            },
                            {
                                label: "Филиал 6",
                                value: "Параметр26080256",
                            },
                            {
                                label: "Филиал 7",
                                value: "Параметр08757823",
                            },
                        ],
                        hasFormRules: false,
                        immutable: false,
                        inputControl: "select",
                        label: "Отделения банка",
                        localizable: true,
                        multiple: false,
                        name: "Поле52832129",
                        predefinedValue: "[]",
                        repeatable: false,
                        required: true,
                        showLabel: true,
                    },
                    {
                        dataType: "string",
                        displayStyle: "singleline",
                        formFieldOptions: [],
                        hasFormRules: false,
                        immutable: false,
                        inputControl: "text",
                        label: "Должность",
                        localizable: true,
                        multiple: false,
                        name: "Поле79534411",
                        predefinedValue: "",
                        repeatable: false,
                        required: true,
                        showLabel: true,
                    },
                    {
                        dataType: "string",
                        displayStyle: "singleline",
                        formFieldOptions: [],
                        hasFormRules: false,
                        immutable: false,
                        inputControl: "text",
                        label: "Дата",
                        localizable: true,
                        multiple: false,
                        name: "Поле57044035",
                        predefinedValue: "",
                        repeatable: false,
                        required: false,
                        showLabel: true,
                    },
                    {
                        dataType: "string",
                        displayStyle: "",
                        formFieldOptions: [],
                        hasFormRules: false,
                        immutable: true,
                        inputControl: "paragraph",
                        label: "Подтвердите отправку",
                        localizable: true,
                        multiple: false,
                        name: "Поле19603894",
                        predefinedValue: "",
                        repeatable: false,
                        required: false,
                        showLabel: true,
                        text: '<p>Подтвердите отправку указанной информации для участия в проекте "Гибкие льготы" kdfjnbkdfjngbkdngbkdыловмлвамлоымолавn</p>\n',
                    },
                ],
                headline: "",
                text: "Просим осуществить выбор льгот ниже.",
            },
        ],
        formSuccessPage: {
            description:
                "<p>Пожалуйста, распечатайте и подпишите загруженные шаблоны, а затем, предоставьте их Брикман Елене Викторовне &lt;Brikman.EV@gazprom-neft.ru&gt; (ДД «Столыпин», Кабинет 1704).</p>\n\n<p>Пересылка персональных данных по почте запрещена</p>\n",
            headline: "Спасибо за то, что воспользовались формой!",
        },
        id: 10666926,
        name: "Форма согласия",
        siteId: 10666787,
    },
};

const mockFormResponse = {
    actions: {},
    facets: [],
    items: [
        {
            creator: {
                additionalName: "",
                contentType: "UserAccount",
                familyName: "Терентьев",
                givenName: "Павел",
                id: 10733932,
                name: "Терентьев Павел",
                profileURL: "/web/terentev.pe",
            },
            dateCreated: "2025-12-24T08:10:39Z",
            dateModified: "2025-12-24T08:28:35Z",
            draft: true,
            formFieldValues: [
                {
                    name: "Поле21985454",
                    value: "Параметр62088148",
                },
                {
                    name: "Поле70642588",
                    value: "Параметр31064982",
                },
                {
                    name: "Поле27256182",
                    value: "",
                },
                {
                    name: "Поле30398955",
                    value: "",
                },
                {
                    name: "Поле56099893",
                    value: "",
                },
                {
                    name: "Поле04690024",
                    value: "",
                },
                {
                    name: "Поле52832129",
                    value: "[]",
                },
                {
                    name: "Поле79534411",
                    value: "",
                },
                {
                    name: "Поле57044035",
                    value: "",
                },
            ],
            id: 10847368,
        },
        {
            creator: {
                additionalName: "",
                contentType: "UserAccount",
                familyName: "Шемяков",
                givenName: "Данила",
                id: 5057601,
                name: "Шемяков Данила",
                profileURL: "/web/shemyakov.de",
            },
            dateCreated: "2025-12-19T07:22:20Z",
            dateModified: "2025-12-19T08:01:52Z",
            draft: true,
            formFieldValues: [
                {
                    name: "Поле21985454",
                    value: "Параметр62088148",
                },
                {
                    name: "Поле70642588",
                    value: "Параметр62088148",
                },
                {
                    name: "Поле27256182",
                    value: "Шемяков Данила",
                },
                {
                    name: "Поле30398955",
                    value: "12345678910",
                },
                {
                    name: "Поле56099893",
                    value: 'ПАО "Газпром нефть"',
                },
                {
                    name: "Поле04690024",
                    value: 'ПАО "Газпром нефть"',
                },
                {
                    name: "Поле52832129",
                    value: "[]",
                },
                {
                    name: "Поле79534411",
                    value: "Консультант",
                },
                {
                    name: "Поле57044035",
                    value: "",
                },
            ],
            id: 10772976,
        },
        {
            creator: {
                additionalName: "",
                contentType: "UserAccount",
                familyName: "Шемяков",
                givenName: "Данила",
                id: 5057601,
                name: "Шемяков Данила",
                profileURL: "/web/shemyakov.de",
            },
            dateCreated: "2025-12-19T07:21:20Z",
            dateModified: "2025-12-19T07:21:20Z",
            draft: true,
            formFieldValues: [
                {
                    name: "Поле21985454",
                    value: "Параметр62088148",
                },
                {
                    name: "Поле70642588",
                    value: "Параметр62088148",
                },
                {
                    name: "Поле27256182",
                    value: "Шемяков Данила",
                },
                {
                    name: "Поле30398955",
                    value: "12345678910",
                },
                {
                    name: "Поле56099893",
                    value: 'ПАО "Газпром нефть"',
                },
                {
                    name: "Поле04690024",
                    value: 'ПАО "Газпром нефть"',
                },
                {
                    name: "Поле52832129",
                    value: "[]",
                },
                {
                    name: "Поле79534411",
                    value: "Консультант",
                },
                {
                    name: "Поле57044035",
                    value: "",
                },
            ],
            id: 10772956,
        },
        {
            creator: {
                additionalName: "",
                contentType: "UserAccount",
                familyName: "Шемяков",
                givenName: "Данила",
                id: 5057601,
                name: "Шемяков Данила",
                profileURL: "/web/shemyakov.de",
            },
            dateCreated: "2025-12-19T07:19:19Z",
            dateModified: "2025-12-19T07:20:20Z",
            draft: true,
            formFieldValues: [
                {
                    name: "Поле21985454",
                    value: "Параметр62088148",
                },
                {
                    name: "Поле70642588",
                    value: "Параметр62088148",
                },
                {
                    name: "Поле27256182",
                    value: "Шемяков Данила",
                },
                {
                    name: "Поле30398955",
                    value: "12345678910",
                },
                {
                    name: "Поле56099893",
                    value: 'ПАО "Газпром нефть"',
                },
                {
                    name: "Поле04690024",
                    value: 'ПАО "Газпром нефть"',
                },
                {
                    name: "Поле52832129",
                    value: "[]",
                },
                {
                    name: "Поле79534411",
                    value: "Консультант",
                },
                {
                    name: "Поле57044035",
                    value: "",
                },
            ],
            id: 10772928,
        },
        {
            creator: {
                additionalName: "",
                contentType: "UserAccount",
                familyName: "Шемяков",
                givenName: "Данила",
                id: 5057601,
                name: "Шемяков Данила",
                profileURL: "/web/shemyakov.de",
            },
            dateCreated: "2025-12-19T07:17:28Z",
            dateModified: "2025-12-19T07:17:28Z",
            draft: true,
            formFieldValues: [
                {
                    name: "Поле21985454",
                    value: "Параметр62088148",
                },
                {
                    name: "Поле70642588",
                    value: "Параметр62088148",
                },
                {
                    name: "Поле27256182",
                    value: "Шемяков Данила",
                },
                {
                    name: "Поле30398955",
                    value: "123456789101",
                },
                {
                    name: "Поле56099893",
                    value: 'ПАО "Газпром нефть"',
                },
                {
                    name: "Поле04690024",
                    value: 'ПАО "Газпром нефть"',
                },
                {
                    name: "Поле52832129",
                    value: "[]",
                },
                {
                    name: "Поле79534411",
                    value: "Консультант",
                },
                {
                    name: "Поле57044035",
                    value: "",
                },
            ],
            id: 10772891,
        },
    ],
    lastPage: 1,
    page: 1,
    pageSize: 100,
    totalCount: 5,
};

const mockApplyResponse = {
    data: {
        arch: "../files/arch.zip",
    },
    response: {
        code: 200,
        message: "User 48901 unregistered. User 38277 moved to reserves",
        status: "success",
        timestamp: "2025-12-17T20:49:50.139786Z",
    },
};

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
        return mockApplyResponse;
        return this._request("/selection/export", {
            method: "POST",
            headers: this._headers,
            body: JSON.stringify({
                data,
                ...this._getDefaultParams(),
            }),
        });
    }

    refuseBenefit() {
        return mockApplyResponse;
        return this._request("/selection/export", {
            method: "POST",
            headers: this._headers,
            body: JSON.stringify(this._getDefaultParams()),
        });
    }
}

class FormApi extends BaseApi {
    constructor(props) {
        super(props);
    }

    getFormData(formId) {
        return mockFormData;

        return this._request(`/${formId}/form-records?page=1&pageSize=100`, {
            headers: this._headers,
        });
    }

    getFormResponse(formId) {
        return mockFormResponse;

        return this._request(`/${formId}/`, {
            headers: this._headers,
        });
    }
}

class BenefitForm {
    constructor(applyBtn, refuseBtn) {
        this._applyBtn = applyBtn;
        this._refuseBtn = refuseBtn;
        this._formId = 1; // взять из скрипта в ftl

        this._fieldsName = {
            food: {
                label: "Выберите опцию для льготы “Оплата питания” *",
                field: "paymentFood",
            },
            vacation: {
                label: "Выберите опцию для льготы “Выплата на оздоровление к отпуску (20 000руб.)”",
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
                "X-CSRF-Token": "Liferay.authToken", // "Liferay.authToken" - снять кавычки при переносе
            },
            baseUrl: `/o/headless-form/v1.0/forms`,
        });

        this._api = new BenefitApi({
            headers: {
                "Content-Type": "application/json",
            },
            baseUrl: EVENT_CONFIG?.baseURL || "/o/benefits",
        });

        this._onApplyClick = this._onApplyClick.bind(this);
        this._onRefuseClick = this._onRefuseClick.bind(this);

        this._applyBtn.addEventListener("click", this._onApplyClick);
        this._refuseBtn.addEventListener("click", this._onRefuseClick);
    }

    async _getFormData() {
        try {
            const res = await this._formApi.getFormData(this._formId);

            return res?.structure?.formPages[0]?.formFields?.filter((field) => {
                return Object.values(this._fieldsName).some(
                    (fieldName) => fieldName.label === field.label
                );
            });
        } catch (err) {}
    }

    async _getFormResponse() {
        try {
            const res = await this._formApi.getFormResponse(this._formId);

            return res?.items[0]?.formFieldValues;
        } catch (err) {}
    }

    _getSelectResponse(dataFileds, fieldName, fieldResponse) {
        const response = dataFileds
            .find((field) => field.label === fieldName)
            ?.formFieldOptions.find((opt) => opt.value === fieldResponse);
        return response?.label;
    }

    _getRadioResponse(dataFileds, fieldName, fieldResponse) {
        const response = dataFileds
            .find((field) => field.label === fieldName)
            ?.formFieldOptions.find((opt) => opt.value === fieldResponse);
        return response?.label === "Перевести в гибкие льготы";
    }

    _getFieldResponse(dataFileds, responseFields, name) {
        const fieldName = dataFileds.find((field) => field.label === name)?.name;
        return responseFields.find((field) => field.name === fieldName)?.value;
    }

    _getInputName(label) {
        return Object.values(this._fieldsName).find((fieldName) => fieldName.label === label);
    }

    _downloadFile(url, fileName) {
        const link = document.createElement("a");
        link.href = url;

        link.setAttribute("download", fileName || url.split("/").pop());

        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }

    async _prepareRequestFromServer() {
        const dataFileds = await this._getFormData();
        const responseFields = await this._getFormResponse();

        if (!dataFileds || !responseFields) return;

        const request = {};

        for (const key in this._fieldsName) {
            const fieldResponse = this._getFieldResponse(
                dataFileds,
                responseFields,
                this._fieldsName[key].label
            );
            request[this._fieldsName[key].field] = fieldResponse;

            if (key === "food") {
                request.paymentFood = this._getRadioResponse(
                    dataFileds,
                    this._fieldsName.food.label,
                    fieldResponse
                );
            }

            if (key === "vacation") {
                request.payout = this._getRadioResponse(
                    dataFileds,
                    this._fieldsName.vacation.label,
                    fieldResponse
                );
            }
        }

        return request;
    }

    async _prepareRequestFromHTML() {
        const request = {};
        const dataFields = await this._getFormData();

        dataFields.forEach((field) => {
            const el = document.querySelector(`[data-field-name=${field.name}]`);

            const textInput = el?.querySelector("input");
            if (textInput) {
                const inputFieldData = this._getInputName(field.label);
                request[inputFieldData.field] = textInput.value;
            }

            if (field.label === this._fieldsName.food.label) {
                const radio = el.querySelector("input:checked");
                const value = radio.value;

                request.paymentFood = this._getRadioResponse(
                    dataFields,
                    this._fieldsName.food.label,
                    value
                );
            }

            if (field.label === this._fieldsName.vacation.label) {
                const radio = el.querySelector("input:checked");
                const value = radio.value;

                request.payout = this._getRadioResponse(
                    dataFields,
                    this._fieldsName.vacation.label,
                    value
                );
            }

            if (field.label === this._fieldsName.bank.label) {
                const selector = el.querySelector("select");
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

            const res = await this._api.applyBenefit(request);
            const fileLink = res?.data.arch;

            if (res?.response?.status === "success") {
                this._downloadFile(fileLink, "Документы");
            }
        } catch (err) {}
    }

    async _onRefuseClick(e) {
        e?.preventDefault();
        e?.stopPropagation();

        try {
            const res = await this._api.refuseBenefit();
            const fileLink = res?.data.arch;

            if (res?.response?.status === "success") {
                this._downloadFile(fileLink, "Документы");
            }
        } catch (err) {}
    }
}

const applyBenefitBtn = document.querySelector("[data-confirm-benefit]");
const refuseBenefitBtn = document.querySelector("[data-refuse-benefit]");

if (applyBenefitBtn && refuseBenefitBtn) {
    new BenefitForm(applyBenefitBtn, refuseBenefitBtn);
}
