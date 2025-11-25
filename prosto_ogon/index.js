class ThanksModal {
    constructor(modalSelector) {
        this._modal = document.querySelector(`.${modalSelector}`);
        this._closeButton = this._modal.querySelector(".modal__close");
        this._handleEscClose = this._handleEscClose.bind(this);
        this._handleOverlayClose = this._handleOverlayClose.bind(this);
    }

    _handleEscClose(e) {
        if (e.key === "Escape") this._close();
    }

    _handleOverlayClose(e) {
        if (e.target === e.currentTarget) this._close();
    }

    open() {
        this._modal.classList.add("modal_is-open");
        document.addEventListener("keydown", this._handleEscClose);
    }

    _close() {
        this._modal.classList.remove("modal_is-open");
        document.removeEventListener("keydown", this._handleEscClose);
    }

    setEventListeners() {
        this._closeButton.addEventListener("click", () => this._close());
        this._modal.addEventListener("click", this._handleOverlayClose);
    }
}

const thanksModal = new ThanksModal("thanks-modal");
thanksModal.setEventListeners();

const cards = document.querySelectorAll(".thanks-item__card");

const handleCardClick = (e) => {
    // если нужно получить саму карточку, то можно получить атрибуты карточки через e.target
    thanksModal.open();
};

cards.forEach((card) => card.addEventListener("click", handleCardClick));
