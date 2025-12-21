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

class FridayApi extends BaseApi {
    constructor(props) {
        super(props);
    }

    getFridayUserInfo() {
        return this._request("/certain_user", {
            method: "POST",
            headers: this._headers,
            body: JSON.stringify(this._getDefaultParams()),
        });
    }

    registerOnFriday(data) {
        return this._request("/_register", {
            method: "POST",
            headers: this._headers,
            body: JSON.stringify({
                data,
                ...this._getDefaultParams(),
            }),
        });
    }

    updateFridayUser(data) {
        return this._request("/user/update", {
            method: "POST",
            headers: this._headers,
            body: JSON.stringify({
                data,
                ...this._getDefaultParams(),
            }),
        });
    }

    unregisterFriday() {
        return this._request("/_unregister", {
            method: "POST",
            headers: this._headers,
            body: JSON.stringify(this._getDefaultParams()),
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

class CoupleInfo {
    constructor(root) {
        this._root = root;

        this._nameEl = this._root.querySelector(".user-label__name ");
        this._workEl = this._root.querySelector(".user-label__work");
        this._avatarEl = this._root.querySelector(".user-label__avatar img");
        this._avatarNameEl = this._root.querySelector(".user-label__avatar-name");
        this._interestsEl = this._root.querySelector(".friday-couple__interests");
        this._link = this._root.querySelector(".friday-couple__link");
    }

    _setContent(data) {
        this._nameEl.textContent = data.fullName;
        this._interestsEl.textContent = data.interests;

        this._avatarNameEl.textContent = `${data.firstName ? data.firstName[0] : ""}${
            data.lastName ? data.lastName[0] : ""
        }`;
        this._workEl.textContent = data.position;
        this._link.href = `mailto:${data.email}`;

        if (data.portraitUrl) {
            this._avatarEl.src = data.portraitUrl;
        } else {
            this._avatarEl.classList.add("_hidden");
        }
    }

    show(data) {
        this._root.classList.remove("_hidden");
        this._setContent(data);
    }

    clear() {
        this._root.classList.add("_hidden");
    }
}

class InterestsModal extends Modal {
    constructor(root, onSubmitCb, onCloseCb) {
        super(root);

        this._root = root;
        this._form = this._root.querySelector(".friday__form");

        this._inputContainer = this._form.querySelector(".friday-form__textarea");
        this._input = this._inputContainer.querySelector("textarea");
        this._submitBtn = this._form.querySelector(".friday-form__submit");

        this._onSubmitCb = onSubmitCb;
        this._onCloseCb = onCloseCb;

        this._isValid = false;
        this.isUpdate = false;

        this._onSubmit = this._onSubmit.bind(this);
        this._onInput = this._onInput.bind(this);

        this.init();
    }

    open(value) {
        super.open();

        this.isUpdate = !!value;
        this._initValue = value || "";
        this._input.value = value || "";
        this._toggleSubmit(this._checkValid());
    }

    reset() {
        this._initValue = "";
        this._input.value = "";
    }

    close() {
        super.close();
        this._onCloseCb?.();
        this.reset();
    }

    onLoading() {
        this._modal.classList.add("_loading");
        this._submitBtn.disabled = true;
    }

    onFinally() {
        this._modal.classList.remove("_loading");
        this._submitBtn.disabled = false;
    }

    _checkValid() {
        const value = this._input.value;

        this._isValid = !!value && this._initValue !== value;

        return this._isValid;
    }

    _toggleSubmit(isValid = true) {
        this._submitBtn.disabled = !isValid;
    }

    _onInput() {
        this._toggleSubmit(this._checkValid());
    }

    _onSubmit(e) {
        e?.preventDefault();

        this._onSubmitCb?.(this._input.value);
    }

    init() {
        this._submitBtn?.addEventListener("click", this._onSubmit);
        this._input?.addEventListener("input", this._onInput);
    }
}

class Friday {
    constructor(root) {
        this._root = root;
        this._unSubHandles = this._root.querySelector(".friday-action__handles-unsub");
        this._subHandles = this._root.querySelector(".friday-action__handles-sub");

        this._subscribeBtn = this._root.querySelector(".friday-action__subscribe");
        this._unSubscribeBtn = this._root.querySelector(".friday-action__unsubscribe");
        this._changeBtn = this._root.querySelector(".friday-action__change");

        this._onUnSubscribeConfirmClick = this._onUnSubscribeConfirmClick.bind(this);
        this._onSubscribeClick = this._onSubscribeClick.bind(this);
        this._onChangeInterestsClick = this._onChangeInterestsClick.bind(this);
        this._onUnSubscribeClick = this._onUnSubscribeClick.bind(this);
        this._onSubmitCb = this._onSubmitCb.bind(this);

        const confirmModalEl = this._root.querySelector(".friday-unsubscribe-confirm-modal");
        confirmModalEl &&
            (this._unSubscribeConfirmModal = new ConfirmModal(
                confirmModalEl,
                this._onUnSubscribeConfirmClick
            ));

        const interestsModalEl = this._root.querySelector(".friday-interests-modal");
        interestsModalEl &&
            (this._interestsModal = new InterestsModal(interestsModalEl, this._onSubmitCb));

        const coupleEl = this._root.querySelector(".friday-couple");
        coupleEl && (this._couple = new CoupleInfo(coupleEl));

        this._api = new FridayApi({
            headers: {
                "Content-Type": "application/json",
            },
            baseUrl: EVENT_CONFIG?.baseURL || "/o/friday",
        });

        this.init();

        this._unSubscribeBtn.addEventListener("click", this._onUnSubscribeClick);
        this._subscribeBtn.addEventListener("click", this._onSubscribeClick);
        this._changeBtn.addEventListener("click", this._onChangeInterestsClick);
    }

    async _getUserInfo() {
        try {
            const data = await this._api.getFridayUserInfo();

            if (data.response.status === "success") {
                return data.data;
            }
        } catch (err) {}
    }

    async _onSubmitCb(value) {
        this._interestsModal.onLoading();

        const isUpdate = this._interestsModal.isUpdate;
        const requestData = { interests: value };
        let data = null;

        try {
            if (isUpdate) {
                data = await this._api.updateFridayUser(requestData);
            } else {
                data = await this._api.registerOnFriday(requestData);
            }

            if (data.response.status === "success") {
                this._interestsModal.close();
                this.init();
            }
        } catch (err) {
        } finally {
            this._interestsModal.onFinally();
        }
    }

    _setContent() {
        if (this._data.isRegistered) {
            this._subHandles.classList.remove("_hidden");
            this._unSubHandles.classList.add("_hidden");
        } else {
            this._subHandles.classList.add("_hidden");
            this._unSubHandles.classList.remove("_hidden");
        }

        if (this._data.couple) {
            this._couple.show(this._data.couple);
        } else {
            this._couple.clear();
        }
    }

    _onChangeInterestsClick() {
        this._interestsModal.open(this._data.interests);
    }

    _onSubscribeClick() {
        this._interestsModal.open();
    }

    async _onUnSubscribeConfirmClick() {
        this._unSubscribeConfirmModal.onLoading();

        try {
            const data = await this._api.unregisterFriday();

            if (data.response.status === "success") {
                this.init();
                this._unSubscribeConfirmModal.close();
            }
        } catch (err) {
        } finally {
            this._unSubscribeConfirmModal.onFinally();
        }
    }

    _onUnSubscribeClick() {
        this._unSubscribeConfirmModal.open();
    }

    async init() {
        this._data = await this._getUserInfo();
        this._setContent();
    }
}

//init
const fridayEl = document.querySelector(".friday");
if (fridayEl) {
    new Friday(fridayEl);
}
