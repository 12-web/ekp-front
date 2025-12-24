<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/portlet_2_0" prefix="portlet" %> <%@ taglib
uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<liferay-theme:defineObjects />
<portlet:defineObjects />

<portlet:actionURL var="savePreferencesURL" />

<style>
    :root {
        --size-text-2xs: 10px;
        --size-text-xs: 12px;
        --size-text-s: 14px;
        --size-text-m: 16px;
        --size-text-l: 18px;
        --size-text-xl: 20px;
        --size-text-2xl: 24px;
        --size-text-3xl: 32px;
        --size-text-4xl: 48px;
        --size-text-5xl: 72px;
        --size-text-6xl: 96px;

        --space-xs: 4px;
        --space-s: 8px;
        --space-m: 16px;
        --space-m-2: 18px;
        --space-l: 24px;
        --space-xl: 32px;
        --space-2xl: 48px;

        --white: #fff;
        --typo-primary: #002033;
        --typo-secondary: #00203399;
        --typo-link: #0078d2;
        --control-ghost-typo: #00395ccc;
        --control-default-bg-border: #00426947;
        --bg-default: #f2f2f2;
        --bg-secondary: #ecf1f4;
        --control-primary-bg: #0078d2;
        --bg-tone: #002033d9;
        --control-default-typo-placeholder: #00203359;
        --control-ghost-bg: #00426912;
        --bg-ghost: #00203314;
        --bg-border: #00416633;
        --color-control-bg-primary-hover: #0091ff;
        --color-bg-alert: #eb57572c;
        --informer-border-alert: #eb5757;
        --color-bg-success: #22c38d2a;
        --informer-border-success: #22c38e;
        --button-color-disable: rgba(0, 32, 51, 0.26);
        --button-bg-color-disable: rgba(0, 66, 105, 0.07);
        --bg-alert: #eb5757;
        --color-control-bg-ghost-hover: rgba(0, 66, 105, 0.05);
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    a {
        text-decoration: none;
    }

    a,
    button {
        -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
        background: transparent;
    }

    input,
    textarea {
        font-family: Inter, Arial, sans-serif;
        background: transparent;
        border: none;
        color: currentColor;
        outline: none;
        padding: 0;
        width: 100%;
    }

    button {
        padding: 0;
        border: 0;
        cursor: pointer;
    }

    ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    body {
        font-family: Inter, Arial, sans-serif;
    }

    *._hidden {
        display: none;
    }

    .cover-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center;
    }

    .visibility-hidden {
        visibility: hidden;
        position: absolute;
        width: 0;
        height: 0;
        margin: 0;
    }

    .with-custom-scrollbar {
        @-moz-document url-prefix("") {
            scrollbar-width: thin;
            scrollbar-color: #0042693d #0042690f;
        }

        &::-webkit-scrollbar {
            width: 5px;
        }

        &::-webkit-scrollbar-thumb {
            border-radius: 4px;
            background-color: #0042693d;
        }

        &::-webkit-scrollbar-track {
            border-radius: 4px;
            background-color: #0042690f;
        }
    }

    .text-1 {
        line-height: 1.5;
        color: var(--typo-primary);
        font-size: var(--size-text-m);
        font-weight: 400;
    }

    .text-2 {
        line-height: 1.5;
        color: var(--typo-primary);
        font-size: var(--size-text-s);
        font-weight: 400;
    }

    ._font-size-2xs {
        font-size: var(--size-text-2x);
    }

    ._font-size-xs {
        font-size: var(--size-text-xs);
    }

    ._font-size-s {
        font-size: var(--size-text-s);
    }

    ._font-size-m {
        font-size: var(--size-text-m);
    }

    ._font-size-l {
        font-size: var(--size-text-l);
    }

    ._font-size-xl {
        font-size: var(--size-text-xl);
    }

    ._font-size-2xl {
        font-size: var(--size-text-2xl);
    }

    ._font-size-3xl {
        font-size: var(--size-text-3xl);
    }

    ._line-height-small {
        line-height: 1.2;
    }

    ._line-height-normal {
        line-height: 1.5;
    }

    ._font-weight-normal {
        font-weight: 400;
    }

    .title-1 {
        font-weight: 700;
        font-size: var(--space-l);
        line-height: 1.8;
    }

    .title-2 {
        font-size: var(--space-l);
        line-height: 1.5;
        color: var(--typo-primary);
        font-weight: 400;
    }

    .title-3 {
        font-size: var(--size-text-xl);
        line-height: 1.5;
        color: var(--typo-primary);
        font-weight: 600;
    }

    .title-4 {
        font-size: var(--size-text-l);
        line-height: 1.5;
        color: var(--typo-primary);
        font-weight: 600;
    }

    .button {
        min-height: var(--space-xl);
        border-radius: var(--space-xs);
        padding-inline: var(--space-m);
        transition: background-color 0.2s;
        font-size: var(--size-text-s);
        border: 1px solid transparent;
        display: flex;
        align-items: center;
        gap: 10px;
        justify-content: center;
        height: fit-content;
    }

    .button_view_primary {
        background-color: var(--control-primary-bg);
        color: var(--white);
    }

    .button_view_primary:disabled {
        background-color: var(--button-bg-color-disable);
        color: var(--button-color-disable);
        cursor: not-allowed;
    }

    .button_view_primary:not(:disabled):hover,
    .button_view_primary:not(:disabled):not(.button_loading):hover {
        background: var(--color-control-bg-primary-hover);
    }

    .button_view_ghost {
        background-color: var(--control-ghost-bg);
        color: var(--control-ghost-typo);
    }

    .button_view_ghost:not(:disabled):hover,
    .button_view_ghost:not(:disabled):not(.button_loading):hover {
        background-color: var(--color-control-bg-ghost-hover);
    }

    .button_view_secondary {
        background-color: transparent;
        border-color: var(--control-primary-bg);
        color: var(--control-primary-bg);
    }

    .button_view_secondary:not(:disabled):hover,
    .button_view_secondary:not(:disabled):not(.button_loading):hover {
        border-color: var(--color-control-bg-primary-hover);
        color: var(--color-control-bg-primary-hover);
    }

    .main {
        margin-inline: auto;
    }

    .c-modal {
        position: fixed;
        inset: 0;
        height: 100%;
        width: 100%;
        background-color: var(--bg-tone);
        z-index: 100;
        opacity: 0;
        visibility: hidden;
        overflow: auto;
        transition: opacity 0.2s, visibility 0.2s;
    }

    .c-modal_is-open {
        opacity: 1;
        visibility: visible;
    }

    .c-modal__content {
        display: flex;
        flex-direction: column;
        background-color: var(--white);
        border-radius: 8px;
        margin: 40px auto;
    }

    .c-modal__title {
        color: var(--typo-primary);
    }

    .c-modal__header {
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
        padding-bottom: 24px;
    }

    .c-modal__header-right {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .c-modal__close {
        flex-shrink: 0;
        width: 32px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .c-modal__close._hidden {
        display: none;
    }

    .c-modal__close-icon {
        width: 16px;
        height: 16px;
    }

    .combobox {
        min-height: 42px;
        border-radius: var(--space-xs);
        border: 1px solid var(--control-default-bg-border);
        display: flex;
        position: relative;
    }

    .combobox._error {
        color: var(--bg-alert);
    }

    .combobox__inner {
        display: flex;
        align-items: center;
        overflow: hidden;

        flex-grow: 1;
        width: 100%;
        height: 100%;
        margin: auto 0;
    }

    .informer {
        padding: var(--space-m);
        border-radius: var(--space-s);
        border: 1px solid transparent;
        display: none;
    }

    .informer._alert {
        background-color: var(--color-bg-alert);
        border-color: var(--informer-border-alert);
    }

    .informer._success {
        background-color: var(--color-bg-success);
        border-color: var(--informer-border-success);
    }

    .informer._show {
        display: block;
    }

    .user-label {
        display: flex;
        align-items: center;
    }

    .user-label__name {
        line-height: 1;
        margin-bottom: 2px;
    }

    .user-label__avatar {
        width: var(--space-xl);
        height: var(--space-xl);
        border-radius: 50%;
        overflow: hidden;
        margin-right: 12px;

        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        background-color: var(--control-primary-bg);
    }

    .user-label__avatar._hidden {
        display: none;
    }

    .user-label__avatar img {
        position: absolute;
        inset: 0;
    }

    .user-label__avatar-name {
        color: var(--white);
        font-size: 10px;
        font-weight: 500;
    }

    .user-label__description {
        font-size: 10px;
        line-height: 1.1;
        color: var(--typo-secondary);
        display: flex;
        align-items: center;
        gap: var(--space-s);
    }

    .user-label__description-item {
        position: relative;
    }

    .user-label__description-item:not(:first-child):before {
        content: "";
        width: 1px;
        height: 100%;
        background-color: var(--typo-secondary);
        position: absolute;
        top: 0;
        left: -4px;
    }

    .friday__stages {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: var(--space-m);
        margin-top: var(--space-xl);
        color: var(--typo-primary);
    }

    @media (max-width: 1440px) {
        .friday__stages {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    .stage-item {
        display: flex;
        flex-direction: column;
        padding: var(--space-m);
        border-radius: 12px;
        border: 1px solid var(--bg-border);
    }

    .stage-item__text {
        margin-top: 12px;
    }

    .stage-item__link {
        color: var(--typo-link);
        margin-top: 6px;
    }

    .friday-action {
        display: flex;
        align-items: center;
        gap: 80px;
        padding: var(--space-xl);
        border-radius: var(--space-s);
        border: 1px solid var(--bg-border);
    }

    .friday-action__img {
        width: 25%;
        height: 292px;
        object-position: center;
        object-fit: contain;
    }

    .friday-action__list {
        margin-top: var(--space-l);
        display: flex;
        flex-direction: column;
        gap: var(--space-s);
        color: var(--typo-primary);
    }

    .friday-action__item::before {
        content: "•";
        margin-right: 2px;
        color: var(--typo-primary);
    }

    .friday-action__handles {
        display: flex;
        margin-top: var(--space-l);
        gap: var(--space-m);
    }

    .friday-action__handles-sub,
    .friday-action__handles-unsub {
        display: flex;
        gap: var(--space-m);
    }

    .friday-action__handles-sub._hidden,
    .friday-action__handles-unsub._hidden {
        display: none;
    }

    .friday-interests-modal._loading .friday-interests-modal__form {
        opacity: 0.6;
        pointer-events: none;
    }

    .friday__modal {
        display: flex;
        align-items: center;
    }

    .friday__modal-content {
        width: 100%;
        max-width: 548px;
        padding: var(--space-xl) 20px 20px;
    }

    .friday-form__textarea textarea {
        padding: var(--space-s);
        border: 1px solid var(--control-default-bg-border);
        border-radius: var(--space-xs);
        min-height: 145px;
        resize: none;
        color: var(--typo-primary);
    }

    .friday-form__textarea textarea::placeholder {
        color: var(--control-default-bg-border);
        font-family: Inter, Arial, sans-serif;
    }

    .friday-form__textarea._error textarea {
        border-color: var(--bg-alert);
    }

    .friday-form__error {
        font-size: 12px;
        color: var(--bg-alert);
        margin-top: var(--space-xs);
        display: none;
    }

    .friday-form__error._visible {
        display: inline-block;
    }

    .friday-subscribe-form__handles,
    .friday-unsubscribe-confirm-modal__handles {
        display: flex;
        gap: 10px;
        margin-top: 20px;
        justify-content: flex-end;
    }

    .friday-couple {
        border-radius: var(--space-m);
        background-color: var(--bg-secondary);
        margin-bottom: var(--space-xl);
        padding: var(--space-m);
        color: var(--typo-primary);
        display: flex;
        flex-direction: column;
    }

    .friday-couple._hidden {
        display: none;
    }

    .friday-couple__bottom {
        display: flex;
        width: 100%;
        justify-content: space-between;
        align-items: flex-end;
        margin-top: var(--space-s);
    }

    .friday-couple__interests {
        max-width: 45%;
    }

    .friday-couple__user {
        margin-top: var(--space-l);
    }
</style>

<!-- Widget Content -->
<section class="friday">
    <div class="friday__couple friday-couple">
        <p class="_font-size-2xl _line-height-normal">Ваша пара на этой неделе</p>
        <div class="friday-couple__user user-label">
            <div class="user-label__avatar">
                <img class="cover-image" src="" alt="аватар" />
                <span class="user-label__avatar-name"></span>
            </div>
            <div class="user-label__about">
                <p class="user-label__name text"></p>
                <div class="user-label__description">
                    <span class="user-label__description-item user-label__work"></span>
                </div>
            </div>
        </div>
        <div class="friday-couple__bottom">
            <p class="friday-couple__interests _font-size-s"></p>
            <a href="/" class="button button_view_primary friday-couple__link"
                ><img src="./images/mail.svg" /><span>Написать на почту</span></a
            >
        </div>
    </div>
    <div class="friday__action friday-action">
        <img src="./images/friday.png" alt="Проект Пятница" class="friday-action__img" />
        <div class="friday-action__about">
            <h2 class="_font-size-3xl _line-height-normal _font-weight-normal">
                &laquo;Пятница&raquo;
            </h2>
            <p class="_font-size-2xl _line-height-normal">Альтернатива офисным кофе-брейкам</p>
            <ul class="friday-action__list">
                <li class="friday-action__item _font-size-m _line-height-norma">
                    Знакомьтесь с коллегами
                </li>
                <li class="friday-action__item _font-size-m _line-height-norma">
                    Прокачайте навыки коммуникации и самопрезентации
                </li>
                <li class="friday-action__item _font-size-m _line-height-norma">
                    Узнавайте о специфике работы других коллег
                </li>
                <li class="friday-action__item _font-size-m _line-height-norma">
                    Найдите наставника или стань им
                </li>
            </ul>
            <div class="friday-action__handles">
                <div class="friday-action__handles-unsub">
                    <button
                        type="button"
                        class="button button_view_primary friday-action__subscribe"
                    >
                        Подписаться
                    </button>
                </div>
                <div class="friday-action__handles-sub">
                    <button
                        type="button"
                        class="button button_view_secondary friday-action__change"
                    >
                        Изменить интересы
                    </button>
                    <button
                        type="button"
                        class="button button_view_ghost friday-action__unsubscribe"
                    >
                        Отписаться
                    </button>
                </div>
            </div>
        </div>
    </div>
    <ul class="friday__stages">
        <li class="friday__stage stage-item">
            <h3 class="stage-item__title _font-size-l _line-height-normal">
                Пары формируются случайным образом
            </h3>
            <p class="stage-item__text _font-size-m _line-height-normal">
                Новая пара будет присылаться на почту каждую пятницу
            </p>
        </li>
        <li class="friday__stage stage-item">
            <h3 class="stage-item__title _font-size-l _line-height-normal">
                Указывайте<br />ваши интересы
            </h3>
            <p class="stage-item__text _font-size-m _line-height-normal">
                Пара увидит интересы друг друга, чтобы было проще начать общение
            </p>
        </li>
        <li class="friday__stage stage-item">
            <h3 class="stage-item__title _font-size-l _line-height-normal">
                Общайтесь<br />без ограничений
            </h3>
            <p class="stage-item__text _font-size-m _line-height-normal">
                Свяжитесь по почте, в TrueConf или другим удобным способом
            </p>
        </li>
        <li class="friday__stage stage-item">
            <h3 class="stage-item__title _font-size-l _line-height-normal">Отличной «Пятницы»!</h3>
            <p class="stage-item__text _font-size-m _line-height-normal">
                Не откладывайте встречу, начинайте общаться сразу
            </p>
            <a class="stage-item__link" href="./files/file.pdf">Как завязать разговор</a>
        </li>
    </ul>
    <div class="friday__modal friday-interests-modal c-modal">
        <div class="c-modal__content friday__modal-content">
            <div class="c-modal__header">
                <h2 class="c-modal__title _font-size-xl _line-height-small">
                    Опишите ваши интересы
                </h2>
            </div>
            <div class="c-modal__body friday__modal-body">
                <form
                    id="friday-subscribe-form"
                    class="friday__form friday-form friday-interests-modal__form"
                    novalidate
                >
                    <div class="friday-form__item friday-form__textarea">
                        <textarea
                            placeholder="Опишите ваши интересы"
                            name="interests"
                            class="_font-size-s _line-height-normal"
                            type="text"
                            required
                        ></textarea>
                        <span class="friday-form__error"></span>
                    </div>
                    <div class="friday-subscribe-form__handles">
                        <button
                            type="submit"
                            class="button button_view_primary friday-form__submit"
                        >
                            Сохранить
                        </button>
                        <button type="button" class="c-modal-close button button_view_ghost">
                            Отмена
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="friday__modal friday-unsubscribe-confirm-modal c-modal">
        <div class="c-modal__content friday__modal-content">
            <div class="c-modal__header">
                <h2 class="c-modal__title _font-size-l _line-height-small _font-weight-normal">
                    Вы подтверждаете отписку от проекта &laquo;Пятница&raquo;
                </h2>
            </div>
            <div class="c-modal__body friday__modal-body">
                <div class="friday-unsubscribe-confirm-modal__handles">
                    <button type="submit" class="button button_view_primary confirm-modal__confirm">
                        Отписаться
                    </button>
                    <button type="button" class="c-modal-close button button_view_ghost">
                        Отмена
                    </button>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    // Добавить siteId, currentUserId, companyId
    var EVENT_CONFIG = {};

    console.log("Event Widget configuration loaded:", EVENT_CONFIG);
</script>

<script src="<%= contextPath %>/META-INF/resources/js/widget.js"></script>
