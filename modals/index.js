//Стандартный класс с поведением модалки
class Modal {
    constructor(config) {
        this._config = config;
        this._modal = document.querySelector(this._config.rootSelector);
        this._closeButton = this._modal?.querySelector(this._config.closeBtnSelector);
        this._handleEscClose = this._handleEscClose.bind(this);
        this._handleOverlayClose = this._handleOverlayClose.bind(this);
        this._close = this._close.bind(this);
    }

    _handleEscClose(e) {
        if (e.key === "Escape") this._close();
    }

    _handleOverlayClose(e) {
        if (e.target === e.currentTarget) this._close();
    }

    open() {
        this._modal.classList.add(this._config.openModalClass);
        document.addEventListener("keydown", this._handleEscClose);
    }

    _close() {
        this._modal.classList.remove(this._config.openModalClass);
        document.removeEventListener("keydown", this._handleEscClose);
    }

    setEventListeners() {
        this._closeButton?.addEventListener("click", this._close);
        this._modal?.addEventListener("click", this._handleOverlayClose);
    }
}

class CircleTimer {
    constructor(root, time, config) {
        this._time = time;
        this._config = config;
        this._root = root;
        this._counter = this._root.querySelector(this._config.counterSelector);
        this._circle = this._root.querySelector(this._config.circleSelector);
        this._max = this._circle.getAttribute("stroke-dasharray");

        this._init();
    }

    _init() {
        this._root.classList.remove(this._config.hiddenClass);
        this._setCounter(this._time);
    }

    _wait(ms) {
        return new Promise((resolve) => setTimeout(resolve, ms));
    }

    _setCounter(counter) {
        this._counter.textContent = counter;
    }

    async on() {
        let intervalId;
        let counter = this._time;
        const intervalTime = 1000;

        this._circle.style.transition = `stroke-dashoffset ${this._time}s linear`;

        this._wait(0).then(() => {
            this._circle.style.strokeDashoffset = `${this._max}`;
        });

        if (intervalId) {
            clearInterval(intervalId);
        }

        intervalId = setInterval(() => {
            counter--;

            this._setCounter(counter);
            if (counter <= 0) clearInterval(intervalId);
        }, intervalTime);

        return this._wait(this._time * 1000).then(() => {
            return true;
        });
    }
}

//Класс модалки с регулировкой открытия по времени
class ModalOnTime extends Modal {
    constructor(config) {
        super(config);
    }

    _openOnTime(lifePeriodH, popupName) {
        const expiredTime = JSON.parse(localStorage.getItem(popupName))?.expired;
        const nowTime = new Date().getTime(); // сейчас в ms

        if (!expiredTime || nowTime > expiredTime) {
            const lifePeriodMs = lifePeriodH * 60 * 60 * 1000; // период сна модалки в ms
            const newExpiredTime = nowTime + lifePeriodMs; // когда попап должен показаться заново

            localStorage.setItem(popupName, JSON.stringify({ expired: newExpiredTime }));

            this.open();
        }
    }

    init(lifePeriodH, autoCloseS) {
        this._openOnTime(lifePeriodH, "popupOnTime");

        if (autoCloseS) {
            this._timerRoot = this._modal.querySelector(this._config.timerSelector);
            if (!this._timerRoot) return;

            this._closeButton.classList.add(this._config.hiddenClass);

            const timer = new CircleTimer(this._timerRoot, autoCloseS, {
                counterSelector: ".progress-timer__counter",
                circleSelector: ".progress-timer__circle",
                hiddenClass: "_hidden",
            });
            timer.on().then(() => this._close());
        } else {
            this.setEventListeners();
        }
    }
}

const modalOnTime = new ModalOnTime({
    rootSelector: ".modal",
    closeBtnSelector: ".modal__close",
    openModalClass: "modal_is-open",
    timerSelector: ".modal__timer",
    hiddenClass: "_hidden",
});

const onLoadPage = async () => {
    // TODO данные из админки (fetch)
    // === сейчас замокано, далее заменить на fetch в бд ===
    const res = await new Promise((resolve) =>
        resolve({
            json: () => {
                return { lifePeriodH: 0.01, autoCloseS: 3 }; // lifePeriodH - период сна модалки, часы; autoCloseS - время для автозакрытия, секунды (если его не передавать, то таймер показывается)
            },
        })
    );
    const data = await res.json();
    // ===========

    modalOnTime.init(data.lifePeriodH, data.autoCloseS);
};

window.addEventListener("load", onLoadPage);
