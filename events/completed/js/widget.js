//utils
const emit = (name, data, element = document, options) => {
    const evt = new CustomEvent(name, {
        detail: data,
        ...options,
    });
    element.dispatchEvent(evt);
};

const listen = (name, handler, element = document, options) => {
    element.addEventListener(name, handler, options);
};

const debounce = (func, delay) => {
    let timeoutId;

    return function (...args) {
        clearTimeout(timeoutId);
        timeoutId = setTimeout(() => {
            func.apply(this, args);
        }, delay);
    };
};

//api
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

class EventsApi extends BaseApi {
    constructor(props) {
        super(props);
    }

    getUsers(data) {
        return this._request("/users/_search", {
            method: "POST",
            headers: this._headers,
            body: JSON.stringify({
                ...data,
                ...this._getDefaultParams(),
            }),
        });
    }

    getEvent(data) {
        return this._request("/certain-event", {
            method: "POST",
            headers: this._headers,
            body: JSON.stringify({
                data,
                ...this._getDefaultParams(),
            }),
        });
    }

    eventRegister(data) {
        return this._request("/events/_register", {
            method: "POST",
            headers: this._headers,
            body: JSON.stringify({
                data,
                ...this._getDefaultParams(),
            }),
        });
    }

    getUserEvents() {
        return this._request("/users/find_user_events", {
            method: "POST",
            headers: this._headers,
            body: JSON.stringify(this._getDefaultParams()),
        });
    }

    cancelEvent(data) {
        return this._request("/_cancel_event", {
            method: "POST",
            headers: this._headers,
            body: JSON.stringify({ data, ...this._getDefaultParams() }),
        });
    }
}

//classes
class Modal {
    _config = {
        closeBtnSelector: ".c-modal-close",
        openModalClass: "c-modal_is-open",
    };

    constructor(root) {
        this._modal = root;
        this.closeButton = this._modal?.querySelector(this._config.closeBtnSelector);

        this._handleEscClose = this._handleEscClose.bind(this);
        this._handleOverlayClose = this._handleOverlayClose.bind(this);
        this.close = this.close.bind(this);

        this.setEventListeners();
    }

    _handleEscClose(e) {
        if (e.key === "Escape") this.close();
    }

    _handleOverlayClose(e) {
        if (e.target === e.currentTarget) this.close();
    }

    open() {
        this._modal.classList.add(this._config.openModalClass);
        document.addEventListener("keydown", this._handleEscClose);
    }

    close() {
        this._modal.classList.remove(this._config.openModalClass);
        document.removeEventListener("keydown", this._handleEscClose);
    }

    setEventListeners() {
        this.closeButton?.addEventListener("click", this.close);
        this._modal?.addEventListener("click", this._handleOverlayClose);
    }
}

class Informer {
    constructor(root) {
        this._root = root;
        this._text = this._root.querySelector(".informer__text");
    }

    _toggle(isShow = true) {
        this._root.classList.toggle("_show", isShow);
    }

    _show(text, viewClass) {
        this._text.textContent = text;
        this._root.classList.add(viewClass);
        this._toggle();
    }

    hide() {
        this._text.textContent = "";
        this._root.classList.remove("_alert", "_success");
        this._toggle(false);
    }

    error(text) {
        this._show(
            text || "Произошла ошибка при запросе. Попробуйте повторить попытку позже",
            "_alert"
        );
    }

    success(text) {
        this._show(text, "_success");
    }
}

class Selector {
    _isOpen = false;
    _config = {
        headerSelector: ".selector__header",
        bodySelector: ".selector__dropdown-content",
        contentSelector: ".selector__dropdown-content__list",
        titleSelector: ".selector__title",
    };

    events = {
        change: "selector-change",
    };

    constructor(root, data) {
        this._selector = root;
        this._header = this._selector.querySelector(this._config.headerSelector);
        this._body = this._selector.querySelector(this._config.bodySelector);
        this._content = this._selector.querySelector(this._config.contentSelector);
        this._title = this._selector.querySelector(this._config.titleSelector);
        this._inputs = [];
        this._checkedInputs = [];
        this._data = data;
        this._template = document.getElementById("registration-event-form-selector-input");

        this._handleHeaderClick = this._handleHeaderClick.bind(this);
        this._handleInputChange = this._handleInputChange.bind(this);

        this._init();
    }

    _init() {
        this._createItems();
        this.setEventListeners();
    }

    _createItems() {
        this._content.innerHTML = "";

        this._data?.forEach((select) => {
            const template = this._template.content.cloneNode(true);
            const input = template.querySelector("input");
            const title = template.querySelector(".selector-dropdown-checkbox__name");

            input.value = select.intervalId;
            title.textContent = `${select.start} - ${select.end}`;

            this._content.appendChild(template);
        });

        this._inputs = Array.from(this._selector.querySelectorAll("input"));
        this._inputs.forEach((input) => input.addEventListener("change", this._handleInputChange));

        const activeInput = this._data[0];

        if (!activeInput) return;

        this._checkedInputs = [activeInput];

        this._title.textContent = `${activeInput.start} - ${activeInput.end}`;

        this._inputs.find(
            (input) => Number(input.value) === Number(activeInput.intervalId)
        ).checked = true;
    }

    _toggle = (isOpen = true) => {
        this._selector.classList.toggle("_opened", isOpen);

        if (isOpen) {
            document.addEventListener("click", this._onOutsideClick);
        } else {
            document.removeEventListener("click", this._onOutsideClick);
        }

        this._isOpen = isOpen;
    };

    _onOutsideClick = (e) => {
        const dropDownContent = e?.target?.closest(".selector__dropdown-content");

        if (!dropDownContent) {
            this._toggle(false);
        }
    };

    _handleHeaderClick(e) {
        e?.stopPropagation();

        this._toggle(!this._isOpen);
    }

    _handleInputChange(e) {
        const id = e?.target.value;

        if (!id) return;
        const checkedItem = this._checkedInputs.find(
            (select) => Number(select.intervalId) === Number(id)
        );

        if (checkedItem) return;

        const newCheckedItem = this._data?.find(
            (select) => Number(select.intervalId) === Number(id)
        );
        this._checkedInputs = [newCheckedItem];

        this._title.textContent = `${newCheckedItem.start} - ${newCheckedItem.end}`;

        this._toggle(false);

        emit(this.events.change, this._checkedInputs);
    }

    setEventListeners() {
        this._header.addEventListener("click", this._handleHeaderClick);
    }
}

class Combobox {
    constructor(root, id) {
        this._root = root;
        this._id = id;
        this._combobox = this._root.querySelector(".combobox");
        this._resetBtn = this._root.querySelector(".combobox__reset");
        this._dropDown = this._root.querySelector(".combobox__dropdown");
        this._input = this._root.querySelector(".combobox__input");

        this._tagContent = this._root.querySelector(".combobox__content");

        this._checkedInputs = [];
        this._tags = [];

        this._onReset = this._onReset.bind(this);
        this._onInput = this._onInput.bind(this);
        this._onDropDown = this._onDropDown.bind(this);
        this._onDeleteClick = this._onDeleteClick.bind(this);
        this._onComboboxClick = this._onComboboxClick.bind(this);

        this.init();
    }

    _onDropDown(e) {
        e?.stopPropagation();

        const isOpen = this._combobox.classList.contains("_opened");

        this._toggle(!isOpen);
    }

    reset() {
        this._tags.forEach((tag) => tag.remove());
        this._tags = [];
        this._checkedInputs = [];

        this._input.value = "";
    }

    _onReset() {
        this.reset(true);
    }

    _onDebounceInput = debounce(this._onInputChange, 600);

    _onInputChange(e) {
        const value = e?.target.value;

        if (!value) return;
        if (value.length === 0) return;

        emit("combobox-input", { value: e.target.value, id: this._id });
    }

    _onInput(e) {
        const value = e?.target.value;

        if (!value) return;

        this._input.style.width = value.length * 1 + "ch";

        this._onDebounceInput(e);
    }

    _removeTag = (id) => {
        if (!id) return;

        const checkedTag = this._tags.find((tag) => Number(tag.dataset.id) === Number(id));

        checkedTag && checkedTag.remove();
        this._tags = this._tags?.filter(
            (tag) => Number(tag.dataset.id) !== Number(checkedTag.dataset.id)
        );
    };

    _onDeleteClick(e) {
        const tagElement = e?.target.closest(".combobox-tag");

        if (!tagElement) return;

        this._removeTag(tagElement.dataset.id);
    }

    _onComboboxClick() {
        this._input.focus();
    }

    _toggle = (isOpen = true) => {
        this._combobox.classList.toggle("_opened", isOpen);

        if (isOpen) {
            document.addEventListener("click", this._onOutsideClick);
        } else {
            document.removeEventListener("click", this._onOutsideClick);
        }
    };

    _onOutsideClick = (e) => {
        const dropDownContent = e?.target?.closest(".combobox__dropdown-content");

        if (!dropDownContent) {
            this._toggle(false);
        }
    };

    init() {
        this._input.addEventListener("input", this._onInput);
        this._resetBtn?.addEventListener("click", this._onReset);
        this._dropDown?.addEventListener("click", this._onDropDown);
        this._tagContent?.addEventListener("click", this._onComboboxClick);
    }
}

class SelectCombobox extends Combobox {
    constructor(root, id) {
        super(root, id);

        this._inputContent = this._root.querySelector(".combobox__dropdown-content__list");

        this._inputTemplate = document.getElementById("combobox-user-input");
        this._tagTemplate = document.getElementById("combobox-user-tag");

        this._values = [];
    }

    _onDropDown(e) {
        e?.stopPropagation();

        const isOpen = this._combobox.classList.contains("_opened");

        this._toggle(!isOpen);
    }

    reset(withEmit) {
        super.reset();

        this._checkedInputs?.forEach((input) => (input.checked = false));
        this._checkedInputs = [];

        if (withEmit) {
            emit("combobox-change", { value: this._checkedInputs, id: this._id });
        }
    }

    _onDeleteClick = (e) => {
        super._onDeleteClick(e);

        const tagElement = e?.target.closest(".combobox-tag");

        if (!tagElement) return;

        const uncheckedInput = this._inputs.find(
            (input) => Number(input.value) === Number(tagElement.dataset.id)
        );
        uncheckedInput && (uncheckedInput.checked = false);

        this._checkedInputs = this._checkedInputs.filter(
            (input) => Number(input.value) !== Number(tagElement.dataset.id)
        );

        emit("combobox-change", { value: this._checkedInputs, id: this._id });
    };

    _createTag(user) {
        const template = this._tagTemplate.content.cloneNode(true);

        const tag = template.querySelector(".combobox-tag");
        const name = template.querySelector(".combobox-tag__name");
        const email = template.querySelector(".combobox-tag__mail");
        const avatar = template.querySelector(".combobox-tag__avatar img");
        const avatarName = template.querySelector(".combobox-tag__avatar-name");
        const deleteBtn = template.querySelector(".combobox-tag__delete");

        deleteBtn.addEventListener("click", this._onDeleteClick);

        name.textContent = user.fullName;

        avatarName.textContent = `${user.firstName ? user.firstName[0] : ""}${
            user.lastName ? user.lastName[0] : ""
        }`;
        email.textContent = user.email;

        tag.dataset.id = user.userId;

        if (user.portraitUrl) {
            avatar.src = user.portraitUrl;
        } else {
            avatar.classList.add("_hidden");
        }

        return { tag, template };
    }

    _onChange = (e) => {
        const input = e?.target;

        if (!input) return;

        const user = this._values.find((user) => Number(user.userId) === Number(input.value));

        if (input.checked) {
            this._checkedInputs?.push(input);
            const { tag, template } = this._createTag(user);
            this._input.before(template);
            this._tags.push(tag);
        } else {
            this._checkedInputs = this._checkedInputs?.filter((item) => item.value !== input.value);
            this._removeTag(Number(user.userId));
        }

        emit("combobox-change", { value: this._checkedInputs, id: this._id });
    };

    setValues(values) {
        this._values = values;

        this._inputContent.innerHTML = "";

        this._values.forEach((user) => {
            const template = this._inputTemplate.content.cloneNode(true);

            const name = template.querySelector(".combobox-dropdown-checkbox__name");
            const email = template.querySelector(".combobox-dropdown-checkbox__email");
            const avatar = template.querySelector(".combobox-dropdown-checkbox__avatar img");
            const avatarName = template.querySelector(".combobox-dropdown-checkbox__avatar-name");
            const input = template.querySelector("input");

            name.textContent = `${user.firstName} ${user.middleName ? user.middleName : ""} ${
                user.lastName ? user.lastName : ""
            }`;
            avatarName.textContent = `${user.firstName ? user.firstName[0] : ""}${
                user.lastName ? user.lastName[0] : ""
            }`;
            email.textContent = user.email;
            input.value = user.userId;

            const isChecked = this._tags.find(
                (tag) => Number(tag.dataset.id) === Number(user.userId)
            );
            input.checked = isChecked;

            if (user.portraitUrl) {
                avatar.src = user.portraitUrl;
            } else {
                avatar.classList.add("_hidden");
            }

            this._inputContent.appendChild(template);
        });

        this._inputs = Array.from(this._inputContent.querySelectorAll("input"));
        this._inputs.forEach((input) => input.addEventListener("change", this._onChange));

        this._toggle();
    }
}

class InputCombobox extends Combobox {
    constructor(root, id) {
        super(root, id);

        this._tagTemplate = document.getElementById("combobox-user-default-tag");

        this._onBlur = this._onBlur.bind(this);

        this._input.addEventListener("blur", this._onBlur);
    }

    _onInput(e) {
        super._onInput(e);
    }

    reset(withEmit) {
        super.reset();

        if (withEmit) {
            emit("combobox-change", { value: this._checkedInputs, id: this._id });
        }
    }

    _createTag(name) {
        const template = this._tagTemplate.content.cloneNode(true);

        const tag = template.querySelector(".combobox-tag");
        const nameEl = template.querySelector(".combobox-tag__name");
        const deleteBtn = template.querySelector(".combobox-tag__delete");

        deleteBtn.addEventListener("click", this._onDeleteClick);

        nameEl.textContent = name;

        tag.dataset.id = this._tags.length;

        return { tag, template };
    }

    _onDeleteClick = (e) => {
        super._onDeleteClick(e);

        const tagElement = e?.target.closest(".combobox-tag");

        if (!tagElement) return;

        this._checkedInputs = this._checkedInputs.filter(
            (input) => Number(input.id) !== Number(tagElement.dataset.id)
        );
        emit("combobox-change", { value: this._checkedInputs, id: this._id });
    };

    _onBlur(e) {
        const name = e?.target.value;

        if (!name) return;

        const { tag, template } = this._createTag(name);
        this._input.before(template);
        this._checkedInputs.push({ id: this._tags.length, value: name });

        this._tags.push(tag);

        this._input.value = "";

        emit("combobox-change", { value: this._checkedInputs, id: this._id });
    }
}

class Checkbox {
    constructor(root) {
        this._root = root;
        this._input = this._root.querySelector("input");
    }

    get checked() {
        return this._input.checked;
    }
}

class RegistrationEvent {
    NOT_EMPLOYEES_COMBOBOX = "not-employees";
    EMPLOYEES_COMBOBOX = "employees";

    constructor(root, openBtn) {
        this._openBtn = openBtn;

        const modal = root;
        this._modal = new Modal(modal);

        const empCombobox = modal.querySelector(".registration-event-form__combobox_type_em");
        empCombobox && (this._empCombobox = new SelectCombobox(empCombobox, "employees"));

        const informer = modal.querySelector(".registration-event__informer");
        informer && (this._informer = new Informer(informer));

        this._form = modal.querySelector(".registration-event__form");
        this._header = modal.querySelector(".registration-event__header");
        this._footer = modal.querySelector(".registration-event__footer");
        this._title = modal.querySelector(".registration-event__title");
        this._text = modal.querySelector(".registration-event__description");
        this._date = modal.querySelector(".registration-event__date");
        this._day = modal.querySelector(".registration-event__day");
        this._contact = modal.querySelector(".registration-event__contact");

        this._notEmpComboboxEl = this._modal._modal.querySelector(
            ".registration-event-form__combobox_type_not-em"
        );
        this._sendNotificationCheckboxEl = this._modal._modal.querySelector(
            ".registration-event-form__checkbox"
        );
        this._submit = modal.querySelector(".registration-event-form__submit");

        this._employees = [];
        this._notEmployees = [];

        this._onModalBtnClick = this._onModalBtnClick.bind(this);
        this._onSelectorChange = this._onSelectorChange.bind(this);
        this._onComboboxChange = this._onComboboxChange.bind(this);
        this._onSubmit = this._onSubmit.bind(this);

        this._isValid = false;
        this._isLoading = false;

        this._limit = 0;

        this._setValid(this._checkLimit());

        listen("selector-change", this._onSelectorChange);
        listen("combobox-input", this._onComboboxInput);
        listen("combobox-change", this._onComboboxChange);

        this._openBtn.addEventListener("click", this._onModalBtnClick);
        this._submit.addEventListener("click", this._onSubmit);

        this._api = new EventsApi({
            headers: {
                "Content-Type": "application/json",
            },
            baseUrl: EVENT_CONFIG?.baseURL || "/o/event-registration-api",
        });

        this.init();
    }

    _onLoading() {
        this._submit.disabled = true;
        this._form.classList.add("_loading");
    }

    _onFinally() {
        this._isValid = false;
        this._setValid(this._isValid);
        this._form.classList.remove("_loading");
    }

    async _onSubmit(e) {
        e?.preventDefault();

        this._onLoading();

        try {
            const request = {
                companyEmployees: this._employees.map((input) => input.value),
                notCompanyEmployees: this._notEmployees.map((input) => input.value),
                intervalId: this._interval.intervalId,
                ...(this._sendNotificationCheckbox
                    ? { isSendEmail: this._sendNotificationCheckbox.checked }
                    : null),
            };

            const data = await this._api.eventRegister(request);

            if (data?.response?.status === "success") {
                this._reset();
                this._informer.success("Вы успешно записались на мероприятие");
                this.init(true);
            }

            if (data?.response?.status === "error") {
                this._informer.error(data?.response?.message);
            }
        } catch (err) {
            this._informer.error();
        } finally {
            this._onFinally();
        }
    }

    _reset() {
        this._empCombobox.reset();
        this._notEmpCombobox.reset();
        this._employees = [];
        this._notEmployees = [];
        this._form.reset();
        this._setValid(false);
    }

    _onModalBtnClick() {
        this._modal.open();
        this._reset();
        this._form.reset();
    }

    _onComboboxChange = (e) => {
        const value = e?.detail;

        if (!value) return;

        if (value.id === this.EMPLOYEES_COMBOBOX) {
            this._getEmployees(value.value.length);
            this._employees = value.value;
        }

        if (value.id === this.NOT_EMPLOYEES_COMBOBOX) {
            this._notEmployees = value.value;
        }

        this._setValid(this._checkLimit());
    };

    _setValid(isValid = true) {
        this._submit.disabled = !isValid;
    }

    _checkLimit() {
        const sum = this._employees.length + this._notEmployees.length;

        if (sum === 0) {
            this._isValid = false;
            this._informer.hide();
            return this._isValid;
        }

        if (sum > this._limit) {
            this._informer.error(`Доступное количество для записи - ${this._limit}`);
            this._isValid = false;
        } else {
            this._informer.hide();
            this._isValid = true;
        }

        return this._isValid;
    }

    async _getEmployees(value) {
        const request = {
            data: {
                search: {
                    query: value,
                },
            },
            pagination: {
                usersLimit: 20,
            },
        };
        const data = this._api.getUsers(request);

        if (data?.data?.items) {
            this._empCombobox.setValues(data.data.items);
        }
    }

    _onComboboxInput = async (e) => {
        const value = e?.detail;

        if (!value) return;

        if (value.id === this.EMPLOYEES_COMBOBOX) {
            this._getEmployees(value.value);
        }
    };

    _onSelectorChange(e) {
        const activeSelector = e?.detail[0];

        if (!activeSelector) return;

        this._interval = activeSelector;
        this._limit =
            activeSelector.count > this._data.entriesNumber
                ? this._data.entriesNumber
                : activeSelector.count;

        this._checkLimit();
    }

    _addTextContend(element, content) {
        if (content) {
            element.textContent = content;
        } else {
            element.classList.add("_hidden");
        }
    }

    _toggleVisible(element, isHide) {
        element?.classList.toggle("_hidden", isHide);
    }

    _setContent(data) {
        const selector = this._form.querySelector(".selector");
        this._selector = new Selector(selector, data.recordingIntervals);

        this._limit =
            data.recordingIntervals[0]?.count > data.entriesNumber
                ? data.entriesNumber
                : data.recordingIntervals[0]?.count || 0;
        this._interval = data.recordingIntervals[0];

        const contact = data?.contacts[0]?.JSONObject;

        this._addTextContend(this._header, data?.header);
        this._addTextContend(this._title, data?.name);
        this._addTextContend(this._text, data?.description);
        this._addTextContend(this._date, data?.date);
        this._addTextContend(this._day, data?.day);
        this._addTextContend(this._contact, contact.fullName);
        this._addTextContend(this._footer, data?.footer);

        const isCreateInputCombo =
            !this._notEmpCombobox && this._notEmpComboboxEl && data.isWithoutEmailRegister;

        if (isCreateInputCombo) {
            this._notEmpCombobox = new InputCombobox(this._notEmpComboboxEl, "not-employees");
        }

        const isCreateCheckbox =
            !this._sendNotificationCheckbox &&
            this._sendNotificationCheckboxEl &&
            data.isShowSendOption;

        if (isCreateCheckbox) {
            this._sendNotificationCheckbox = new Checkbox(this._sendNotificationCheckboxEl);
        }

        this._toggleVisible(this._notEmpComboboxEl, !data.isWithoutEmailRegister);
        this._toggleVisible(this._sendNotificationCheckboxEl, !data.isShowSendOption);
    }

    async init(withoutInformer = false) {
        if (!EVENT_CONFIG.eventId) return;

        const eventId = EVENT_CONFIG.eventId;

        const data = await this._api.getEvent({ eventId: Number(eventId) });

        if (!data?.data) return;

        this._data = data.data;

        this._setContent(this._data);

        if (withoutInformer) return;

        if (data?.response?.status === "error") {
            this._informer.error(
                data?.response?.message ||
                    "Произошла ошибка при загрузке данных. Попробуйте повторить попытку позже"
            );
            this._modal._modal.classList.add("_blocked");
        } else {
            this._informer.hide();
        }

        if (this._data.isClose) {
            this._modal._modal.classList.add("_blocked");
            this._informer.error("Запись на мероприятие недоступна");
        }
    }
}

class ConfirmModal extends Modal {
    constructor(root, onConfirmCb, onCloseCb) {
        super(root);

        this._confirmBtn = this._modal?.querySelector(".confirm-modal__confirm");

        this._onCloseCb = onCloseCb;
        this._onConfirmCb = onConfirmCb;

        this._onConfirmClick = this._onConfirmClick.bind(this);

        this.init();
    }

    close() {
        super.close();
        this._onCloseCb?.();
    }

    onLoading() {
        this._modal.classList.add("_loading");
        this._confirmBtn.disabled = true;
    }

    onFinally() {
        this._modal.classList.remove("_loading");
        this._confirmBtn.disabled = false;
    }

    _onConfirmClick() {
        this._onConfirmCb?.();
    }

    init() {
        this._confirmBtn?.addEventListener("click", this._onConfirmClick);
    }
}

class EventListItem {
    constructor(template, onUnSubscribeCb) {
        this._template = template;

        this._onUnSubscribeCb = onUnSubscribeCb;
        this._onUnSubscribeClick = this._onUnSubscribeClick.bind(this);
    }

    _createContent() {
        const template = this._template.content.cloneNode(true);
        const baseClass = "registration-event-list-item";

        const name = template.querySelector(`.${baseClass}__name`);
        const date = template.querySelector(`.${baseClass}__date`);
        const day = template.querySelector(`.${baseClass}__day`);

        const subscriber = template.querySelector(`.${baseClass}__subscriber-user`);
        const subscriberInfo = template.querySelector(`.${baseClass}__subscriber-info`);

        if (this._data.isRegisteredByOtherMan) {
            const subscriberName = template.querySelector(`.${baseClass}__subscriber-name`);
            const subscriberLink = template.querySelector(`.${baseClass}__subscriber-link`);

            subscriberInfo.textContent = "Вас записал: ";
            subscriberName.textContent = this._data.registrationCreator?.fullName || "";
            subscriberLink.textContent = this._data.registrationCreator?.email || "";
            subscriberLink.href = `mailto:${this._data.registrationCreator?.email || ""}`;

            subscriber.classList.remove("_hidden");
        } else {
            subscriberInfo.textContent = "";

            subscriber.classList.add("_hidden");
        }

        this._unSubscribeBtn = template.querySelector('[data-id="button-register"]');

        name.textContent = this._data.event.name;
        date.textContent = this._data.event.date;
        day.textContent = this._data.event.day;

        this._unSubscribeBtn?.addEventListener("click", this._onUnSubscribeClick);

        return template;
    }

    _onUnSubscribeClick() {
        this._onUnSubscribeCb(this._data.event.eventId);
    }

    create(data) {
        this._data = data;

        return this._createContent();
    }

    destroy() {
        this._unSubscribeBtn?.removeEventListener("click", this._onUnSubscribeClick);
    }
}

class UserEventsList {
    constructor(root) {
        this._root = root;

        this._onUnSubscribeClick = this._onUnSubscribeClick.bind(this);
        this._onConfirmClick = this._onConfirmClick.bind(this);

        const confirmModalEl = document.querySelector(".registration-event-list-confirm-modal");

        this._notFoundEl = document.querySelector(".registration-event-list-not-found");

        this._confirmModal = new ConfirmModal(
            confirmModalEl,
            this._onConfirmClick,
            this._onCloseCb
        );

        this._items = [];

        this._unsubscribingEventId = null;

        this._api = new EventsApi({
            headers: {
                "Content-Type": "application/json",
            },
            baseUrl: EVENT_CONFIG?.baseURL || "/",
        });

        this.init();
    }

    _clear() {
        this._root.innerHTML = "";
        this._items?.forEach((item) => item.destroy());
        this._items = [];
    }

    _initItems(data) {
        this._clear();

        const template = document.getElementById("registration-event-list-item");

        if (!data || !data.length) {
            this._notFoundEl.classList.remove("_hidden");
        } else {
            this._notFoundEl.classList.add("_hidden");

            data.forEach((item) => {
                const listItem = new EventListItem(template, this._onUnSubscribeClick);
                this._items.push(listItem);

                this._root.appendChild(listItem.create(item));
            });
        }
    }

    async _getListItems() {
        const data = await this._api.getUserEvents();

        if (data?.data) {
            this._initItems(data?.data);
        }
    }

    async _onConfirmClick() {
        if (!this._unsubscribingEventId) return;

        this._confirmModal.onLoading();

        try {
            const data = await this._api.cancelEvent({
                eventId: Number(this._unsubscribingEventId),
            });

            if (data?.response.success) {
                this.init();
                this._confirmModal.close();
            }
        } catch (err) {
        } finally {
            this._confirmModal.onFinally();
        }
    }

    _onCloseCb() {
        this._unsubscribingEventId = null;
    }

    _onUnSubscribeClick(id) {
        this._confirmModal.open();
        this._unsubscribingEventId = id;
    }

    init() {
        this._getListItems();
    }
}

//init
const userEventsListEl = document.querySelector(".registration-event-list");
if (userEventsListEl) {
    new UserEventsList(userEventsListEl);
}

const registrationEventModalEl = document.querySelector(".registration-event-modal");
const registrationEventBtnEl = document.querySelector('[data-modal="registration-event-modal"]');

if (registrationEventModalEl && registrationEventBtnEl) {
    new RegistrationEvent(registrationEventModalEl, registrationEventBtnEl);
}
