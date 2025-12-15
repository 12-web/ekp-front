<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/portlet_2_0" prefix="portlet" %> <%@ taglib
uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<liferay-theme:defineObjects />
<portlet:defineObjects />

<% // Get settings from Java class String mainSiteIdStr = (String)
renderRequest.getAttribute("mainSiteId"); String eventId = (String)
renderRequest.getAttribute("eventId"); Boolean isWidgetVisibleObj = (Boolean)
renderRequest.getAttribute("isWidgetVisible"); Boolean isListingVisibleObj = (Boolean)
renderRequest.getAttribute("isListingVisible"); Boolean isConfiguredObj = (Boolean)
renderRequest.getAttribute("isConfigured"); // Default values if (mainSiteIdStr == null)
mainSiteIdStr = ""; if (eventId == null) eventId = ""; if (isWidgetVisibleObj == null)
isWidgetVisibleObj = true; if (isListingVisibleObj == null) isListingVisibleObj = true; if
(isConfiguredObj == null) isConfiguredObj = false; boolean isWidgetVisible =
isWidgetVisibleObj.booleanValue(); boolean isListingVisible = isListingVisibleObj.booleanValue();
boolean isConfigured = isConfiguredObj.booleanValue(); String widgetVisibilityClass =
isWidgetVisible ? "" : "widget-hidden"; String listingVisibilityClass = isListingVisible ? "" :
"listing-hidden"; // Get context path String contextPath = request.getContextPath(); %>

<portlet:actionURL var="savePreferencesURL" />

<style>
    .event-widget {
        width: 300px;
        min-height: 100px;
        border: 1px solid #ccc;
        border-radius: 4px;
        padding: 15px;
        background: white;
        font-family: Arial, sans-serif;
    }

    .config-form {
        background: #f9f9f9;
        padding: 15px;
        border-radius: 4px;
    }

    .form-group {
        margin-bottom: 12px;
    }

    .form-label {
        display: block;
        font-weight: bold;
        margin-bottom: 4px;
        font-size: 13px;
        color: #333;
    }

    .form-input {
        width: 100%;
        padding: 6px;
        border: 1px solid #ddd;
        border-radius: 3px;
        box-sizing: border-box;
        font-size: 13px;
    }

    .form-checkbox {
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 13px;
        color: #333;
    }

    .form-button {
        width: 100%;
        padding: 8px;
        background: #007bff;
        color: white;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        font-size: 13px;
    }

    .form-button:hover {
        background: #0056b3;
    }

    .alert {
        padding: 8px 12px;
        border-radius: 3px;
        margin-bottom: 10px;
        font-size: 13px;
    }

    .alert-success {
        background: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }

    .alert-error {
        background: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }

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
        --control-ghost-typo: #00395ccc;
        --control-default-bg-border: #00426947;
        --bg-default: #f2f2f2;
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
        background-color: var(--bg-default);
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

    .text {
        line-height: 1.5;
        color: var(--typo-primary);
        font-size: 14px;
        font-weight: 400;
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

    .text-3 {
        line-height: 1.5;
        color: var(--typo-primary);
        font-size: var(--size-text-xs);
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

    .button {
        min-height: var(--space-xl);
        border-radius: var(--space-xs);
        padding-inline: var(--space-m);
        transition: background-color 0.2s;
        font-size: var(--size-text-s);
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

    .button_view_ghost {
        background-color: var(--control-ghost-bg);
        color: var(--control-ghost-typo);
    }

    .button_view_ghost:not(:disabled):hover,
    .button_view_ghost:not(:disabled):not(.button_loading):hover {
        background-color: var(--color-control-bg-ghost-hover);
    }

    .button_view_primary:not(:disabled):hover,
    .button_view_primary:not(:disabled):not(.button_loading):hover {
        background: var(--color-control-bg-primary-hover);
    }

    .main {
        margin-inline: auto;
    }

    .modal {
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

    .modal_is-open {
        opacity: 1;
        visibility: visible;
    }

    .modal__content {
        display: flex;
        flex-direction: column;
        background-color: var(--white);
        border-radius: 8px;
    }

    .modal__header {
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
        padding-bottom: 24px;
    }

    .modal__header-right {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .modal__close {
        flex-shrink: 0;
        width: 32px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .modal__close._hidden {
        display: none;
    }

    .modal__close-icon {
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

    .combobox__content {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        flex-grow: 1;
        width: 100%;
        height: 100%;
        padding: var(--space-xs) var(--space-s);
        gap: 2px;
        cursor: pointer;
    }

    .combobox__dropdown {
        flex-shrink: 0;
        min-height: var(--space-xl);
        width: var(--space-xl);
        display: flex;
        align-items: center;
        justify-content: center;
        border-left: 1px solid var(--control-default-bg-border);
    }

    .combobox__dropdown svg {
        fill: var(--control-default-typo-placeholder);
    }

    .combobox__dropdown-content:has(> .combobox__dropdown-content__list:empty)
        + .combobox__dropdown {
        pointer-events: none;
    }

    .combobox__reset {
        width: var(--space-xl);
        height: var(--space-xl);
        align-items: center;
        justify-content: center;
        display: none;
    }

    .combobox__reset svg {
        fill: var(--control-default-typo-placeholder);
    }

    .combobox__content:has(> .combobox-tag) + .combobox__reset {
        display: flex;
    }

    .combobox__input {
        width: 10px;
    }

    .combobox__dropdown-content {
        width: 100%;
        background-color: var(--white);
        position: absolute;
        top: calc(100% + 2px);
        left: 0;
        z-index: 5;
        border-radius: var(--space-xs);
        border: 1px solid transparent;
        overflow: auto;
        height: 0;
        max-height: 180px;
    }

    .combobox._opened .combobox__dropdown-content {
        height: auto;
        border-color: var(--control-default-bg-border);
    }

    .combobox__dropdown-content__list {
        display: flex;
        flex-direction: column;
        gap: var(--space-xs);
        padding: var(--space-s);
    }

    .combobox-tag {
        display: flex;
        align-items: center;
        background-color: var(--control-ghost-bg);
        border-radius: 99px;
        padding: 4px var(--space-s) 4px 4px;
        flex-shrink: 0;
        gap: 8px;
    }

    .combobox-tag__avatar {
        width: 24px;
        height: 24px;
        border-radius: 50%;
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        background-color: var(--control-primary-bg);
    }

    .combobox-tag__avatar_type_default {
        background-color: transparent;
    }

    .combobox-tag__avatar img {
        position: absolute;
        inset: 0;
        width: 100%;
        height: 100%;
    }

    .combobox-tag__avatar-name {
        color: var(--white);
        font-size: 10px;
        font-weight: 500;
    }

    .combobox-tag__info {
        display: flex;
        flex-direction: column;
        gap: 1px;
        margin-right: var(--space-xs);
    }

    .combobox-tag__name {
        font-size: 12px;
        line-height: 1;
        color: var(--typo-primary);
    }

    .combobox-tag__mail {
        color: var(--typo-secondary);
        font-size: 10px;
        line-height: 1.1;
    }

    .combobox-tag__delete {
        width: 12px;
        height: 12px;
        display: flex;
        align-items: center;
    }

    .combobox-tag__delete svg {
        fill: var(--control-ghost-typo);
    }

    .combobox-dropdown-checkbox {
        display: flex;
        align-items: center;
        cursor: pointer;
        position: relative;
    }

    .combobox-dropdown-checkbox:has(.combobox-dropdown-checkbox__input:checked)
        .combobox-dropdown-checkbox__check {
        background-color: var(--control-primary-bg);
        border-color: var(--control-primary-bg);
    }

    .combobox-dropdown-checkbox:has(.combobox-dropdown-checkbox__input:checked)
        .combobox-dropdown-checkbox__check::before {
        opacity: 1;
    }

    .combobox-dropdown-checkbox__content {
        display: flex;
        align-items: center;
        flex-shrink: 0;
    }

    .combobox-dropdown-checkbox__avatar {
        width: var(--space-l);
        height: var(--space-l);
        border-radius: 50%;
        overflow: hidden;
        margin-right: 6px;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        background-color: var(--control-primary-bg);
    }

    .combobox-dropdown-checkbox__avatar img {
        position: absolute;
        inset: 0;
    }

    .combobox-dropdown-checkbox__avatar-name {
        color: var(--white);
        font-size: 10px;
        font-weight: 500;
    }

    .combobox-dropdown-checkbox__email {
        font-size: 10px;
        line-height: 1.1;
        color: var(--typo-secondary);
        display: flex;
        align-items: center;
        gap: var(--space-s);
    }

    .combobox-dropdown-checkbox__check {
        width: var(--space-m);
        height: var(--space-m);
        position: relative;
        background-color: transparent;
        margin-right: var(--space-s);
        border-radius: 2px;
        border: 1px solid var(--control-default-bg-border);
    }

    .combobox-dropdown-checkbox__check::before {
        border-bottom: 2px solid var(--white);
        border-left: 2px solid var(--white);
        box-sizing: border-box;
        content: "";
        height: calc(var(--space-m) * 0.35);
        left: calc(var(--space-m) / 5 - 1.2px);
        opacity: 1;
        position: absolute;
        top: calc(var(--space-m) / 2 - 0.5px);
        transition: opacity 0.15s;
        width: calc(var(--space-m) * 0.6);
        transform: rotate(-45deg) translate(-5%, -5%);
        transform-origin: 0 0;
    }

    .selector {
        min-height: 42px;
        border-radius: var(--space-xs);
        border: 1px solid var(--control-default-bg-border);
        display: flex;
        position: relative;
    }

    .selector._error {
        color: var(--bg-alert);
    }

    .selector__inner {
        display: flex;
        align-items: center;
        overflow: hidden;

        flex-grow: 1;
        width: 100%;
    }

    .selector__content {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        flex-grow: 1;
        width: 100%;
        height: 100%;
        padding: var(--space-xs) var(--space-s);
        gap: 2px;
    }

    .selector__dropdown {
        flex-shrink: 0;
        min-height: var(--space-xl);
        width: var(--space-xl);
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .selector__dropdown svg {
        fill: var(--control-default-typo-placeholder);
    }

    .selector__reset {
        width: var(--space-xl);
        height: var(--space-xl);
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .selector__reset svg {
        fill: var(--control-default-typo-placeholder);
    }

    .selector__title {
        color: var(--typo-primary);
    }

    .selector__input {
        width: fit-content;
    }

    .selector__dropdown-content {
        width: 100%;
        background-color: var(--white);
        position: absolute;
        top: calc(100% + 2px);
        left: 0;
        z-index: 5;
        border-radius: var(--space-xs);
        border: 1px solid transparent;
        overflow: hidden;
        height: 0;
        max-height: 180px;
    }

    .selector._opened .selector__dropdown-content {
        height: auto;
        border-color: var(--control-default-bg-border);
    }

    .selector__dropdown-content__list {
        display: flex;
        flex-direction: column;
        gap: var(--space-xs);
        padding: var(--space-s);
    }

    .selector__header {
        display: flex;
        align-items: center;
        width: 100%;
        cursor: pointer;
    }

    .selector__header-inner {
        flex-grow: 1;
        padding: 4px 8px;
    }

    .selector-dropdown-checkbox {
        display: flex;
        align-items: center;
        cursor: pointer;
    }

    .selector-dropdown-checkbox:has(.selector-dropdown-checkbox__input[type="checkbox"]:checked)
        .selector-dropdown-checkbox__check {
        background-color: var(--control-primary-bg);
        border-color: var(--control-primary-bg);
    }

    .selector-dropdown-checkbox:has(.selector-dropdown-checkbox__input:checked)
        .selector-dropdown-checkbox__check::before {
        opacity: 1;
    }

    .selector-dropdown-checkbox__content {
        display: flex;
        align-items: center;
        flex-shrink: 0;
    }

    .selector-dropdown-checkbox__avatar {
        width: var(--space-l);
        height: var(--space-l);
        border-radius: 50%;
        overflow: hidden;
        margin-right: 6px;
    }

    .selector-dropdown-checkbox__work {
        font-size: 10px;
        line-height: 1.1;
        color: var(--typo-secondary);
        display: flex;
        align-items: center;
        gap: var(--space-s);
    }

    .selector-dropdown-checkbox__input[type="checkbox"] + .selector-dropdown-checkbox__check {
        width: var(--space-m);
        height: var(--space-m);
        position: relative;
        background-color: transparent;
        margin-right: var(--space-s);
        border-radius: 2px;
        border: 1px solid var(--control-default-bg-border);
    }

    .selector-dropdown-checkbox__input[type="checkbox"]
        + .selector-dropdown-checkbox__check::before {
        border-bottom: 2px solid var(--white);
        border-left: 2px solid var(--white);
        box-sizing: border-box;
        content: "";
        height: calc(var(--space-m) * 0.35);
        left: calc(var(--space-m) / 5 - 1.2px);
        opacity: 1;
        position: absolute;
        top: calc(var(--space-m) / 2 - 0.5px);
        transition: opacity 0.15s;
        width: calc(var(--space-m) * 0.6);
        transform: rotate(-45deg) translate(-5%, -5%);
        transform-origin: 0 0;
    }

    .selector-dropdown-checkbox__input[type="radio"] + .selector-dropdown-checkbox__check {
        width: var(--space-m);
        height: var(--space-m);
        position: relative;
        background-color: transparent;
        margin-right: var(--space-s);
        border-radius: 50%;
        border: 1px solid var(--control-default-bg-border);
    }

    .selector-dropdown-checkbox__input[type="radio"] + .selector-dropdown-checkbox__check::before {
        content: "";
        height: 50%;
        width: 50%;
        left: 50%;
        opacity: 0;
        position: absolute;
        background-color: var(--control-primary-bg);
        border-radius: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        transition: opacity 0.15s;
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

    .ui-checkbox {
        display: flex;
        align-items: center;
        cursor: pointer;
    }

    .ui-checkbox:has(.ui-checkbox__input:checked) .ui-checkbox__check {
        background-color: var(--control-primary-bg);
        border-color: var(--control-primary-bg);
    }

    .ui-checkbox:has(.ui-checkbox__input:checked) .ui-checkbox__check::before {
        opacity: 1;
    }

    .ui-checkbox__content {
        display: flex;
        align-items: center;
        flex-shrink: 0;
    }

    .ui-checkbox__avatar {
        width: var(--space-l);
        height: var(--space-l);
        border-radius: 50%;
        overflow: hidden;
        margin-right: 6px;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: var(--control-primary-bg);
    }

    .ui-checkbox__avatar-name {
        color: var(--white);
        font-size: 10px;
        font-weight: 500;
    }

    .ui-checkbox__email {
        font-size: 10px;
        line-height: 1.1;
        color: var(--typo-secondary);
        display: flex;
        align-items: center;
        gap: var(--space-s);
    }

    .ui-checkbox__check {
        width: var(--space-m);
        height: var(--space-m);
        position: relative;
        background-color: transparent;
        margin-right: var(--space-s);
        border-radius: 2px;
        border: 1px solid var(--control-default-bg-border);
    }

    .ui-checkbox__check::before {
        border-bottom: 2px solid var(--white);
        border-left: 2px solid var(--white);
        box-sizing: border-box;
        content: "";
        height: calc(var(--space-m) * 0.35);
        left: calc(var(--space-m) / 5 - 1.2px);
        opacity: 1;
        position: absolute;
        top: calc(var(--space-m) / 2 - 0.5px);
        transition: opacity 0.15s;
        width: calc(var(--space-m) * 0.6);
        transform: rotate(-45deg) translate(-5%, -5%);
        transform-origin: 0 0;
    }

    .registration-event {
        overflow: auto;
        display: flex;
        flex-direction: column;
        flex-grow: 1;
    }

    .registration-event__header,
    .registration-event__footer {
        padding-block: 24px;
        border-top: 1px solid var(--bg-border);
        border-bottom: 1px solid var(--bg-border);
    }

    .registration-event__footer {
        margin-bottom: 24px;
    }

    .registration-event__handles {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin-top: auto;
    }

    .registration-event__info {
        padding-block: var(--space-l);
        border-bottom: 1px solid var(--bg-border);
    }

    .registration-event__additional {
        display: flex;
        align-items: flex-start;
        gap: 20px;
        padding-top: var(--space-xl);
    }

    .registration-event__title {
        font-weight: 700;
        margin-top: var(--space-xs);
    }

    .registration-event__contact {
        font-weight: 700;
    }

    .registration-event__info-col {
        display: flex;
        align-items: flex-start;
        gap: var(--space-m);
        max-width: 335px;
        width: 100%;
    }

    .registration-event__info-icon {
        width: 24px;
        height: 24px;
    }

    .registration-event__day,
    .registration-event__contact-caption {
        color: var(--typo-secondary);
        margin-top: var(--space-xs);
    }

    .registration-event-modal._blocked .registration-event__form {
        opacity: 0.6;
        pointer-events: none;
    }

    .registration-event__form {
        padding-block: var(--space-l);
    }

    .registration-event__form._loading {
        opacity: 0.6;
        pointer-events: none;
    }

    .registration-event__parts-title {
        color: var(--typo-secondary);
        font-weight: 500;
        margin-bottom: 20px;
    }

    .registration-event-form__item {
        display: flex;
        flex-direction: column;
    }

    .registration-event-form__item._hidden {
        display: none;
    }

    .registration-event-form__item:not(:last-child) {
        margin-bottom: 20px;
    }

    .registration-event-form__label {
        color: var(--typo-secondary);
        margin-bottom: var(--space-s);
    }

    .registration-event__informer {
        margin-bottom: var(--space-m);
    }

    .registration-event-modal__content {
        padding: 32px 20px 20px;

        min-height: 672px;
        max-width: 738px;
        width: 738px;
        margin: 40px auto;
    }

    .registration-event-list {
        display: flex;
        flex-direction: column;
        width: 100%;
        padding: var(--space-m);
        gap: var(--space-s);
    }
    .registration-event-list-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: var(--space-m);
        width: 100%;
        padding: var(--space-m);
        border-radius: var(--space-s);
        background-color: var(--white);
        color: var(--typo-primary);
    }

    .registration-event-list-item__subscriber {
        margin-left: auto;
        max-width: 30%;
    }

    .registration-event-list-item__subscriber a {
        color: var(--control-primary-bg);
    }

    .confirm-modal {
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .confirm-modal._loading .confirm-modal__confirm {
        opacity: 0.6;
        cursor: not-allowed;
    }

    .confirm-modal__modal-content {
        width: 100%;
        max-width: 450px;
        padding: var(--space-xl) 20px 20px;
    }

    .registration-event-list-confirm-modal__handles {
        display: flex;
        align-items: center;
        justify-content: flex-end;
        gap: var(--space-xs);
    }

    .registration-event-list-item__subscriber-user {
        display: flex;
    }

    .registration-event-list-item__subscriber-user._hidden {
        display: none;
    }

    .registration-event-list-item__subscriber-name {
        margin-right: 4px;
    }

    /* Важные стили для управления видимостью */

    .config-content {
        width: 100%;
    }
</style>

<div class="event-widget">
    <!-- Configuration Form -->
    <div class="config-content" style="display: <%= !isConfigured ? "block" : "none" %>">
    <div class="config-form">
        <h3 style="margin: 0 0 15px 0; font-size: 16px; color: #333">Widget Configuration</h3>

        <c:if test="${not empty preferencesSaved}">
            <div class="alert alert-success">${preferencesSaved}</div>
        </c:if>

        <c:if test="${not empty saveError}">
            <div class="alert alert-error">${saveError}</div>
        </c:if>

        <form action="<%= savePreferencesURL %>" method="post">
            <div class="form-group">
                <label class="form-label">Main Site ID:</label>
                <input
                    type="text"
                    name="<portlet:namespace />mainSiteId"
                    class="form-input"
                    placeholder="Enter site ID"
                    value="<%= mainSiteIdStr %>"
                    required
                    pattern="[0-9]+"
                />
            </div>

            <div class="form-group">
                <label class="form-label">Event ID:</label>
                <input
                    type="text"
                    name="<portlet:namespace />eventId"
                    class="form-input"
                    placeholder="Enter event ID"
                    value="<%= eventId %>"
                    required
                />
            </div>

            <!-- Visibility configuration checkboxes -->
            <div class="form-group">
                <label class="form-checkbox">
                    <input type="checkbox" name="<portlet:namespace />isWidgetVisible" value="true"
                    <%= isWidgetVisible ? "checked" : "" %>> Show widget content
                </label>
            </div>

            <div class="form-group">
                <label class="form-checkbox">
                    <input type="checkbox" name="<portlet:namespace />isListingVisible" value="true"
                    <%= isListingVisible ? "checked" : "" %>> Show event listing (separate section)
                </label>
            </div>

            <button type="submit" class="form-button">Save Settings</button>
        </form>
    </div>
</div>

<!-- Widget Content -->
<% if (isWidgetVisible) { %> <% if (isConfigured) { %>
<button
    data-modal="registration-event-modal"
    type="button"
    class="button button_view_primary"
    id="widget-content-container"
>
    Открыть
</button>
<% } %>
<div class="registration-event-modal modal">
    <div class="modal__content registration-event-modal__content">
        <div class="modal__header">
            <h2 class="modal__title title-3">Регистрация на мероприятие</h2>
        </div>
        <div class="modal__body registration-event with-custom-scrollbar">
            <div class="registration-event__header text-1"></div>

            <div class="registration-event__info">
                <h3 class="registration-event__title title-3"></h3>
                <p class="registration-event__description text-1"></p>
                <div class="registration-event__additional">
                    <div class="registration-event__info-col">
                        <img src="./images/time.svg" class="registration-event__info-icon" />
                        <div>
                            <p class="title-4 registration-event__date"></p>
                            <p class="text-1 registration-event__day"></p>
                        </div>
                    </div>
                    <div class="registration-event__info-col">
                        <img src="./images/user.svg" class="registration-event__info-icon" />
                        <div>
                            <p class="title-4 registration-event__contact"></p>
                            <p class="text-1 registration-event__contact-caption">
                                Контактное лицо
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <form id="registration-form" class="registration-event__form">
                <div class="registration-event__parts">
                    <p class="title-3 registration-event__parts-title">Участники мероприятия</p>
                    <div
                        class="registration-event-form__item registration-event-form__combobox registration-event-form__combobox_type_em"
                    >
                        <label for="user-search" class="registration-event-form__label text-1"
                            >Cотрудники Компании</label
                        >
                        <div class="combobox">
                            <div class="combobox__inner">
                                <div class="combobox__content">
                                    <input
                                        name="user-search"
                                        id="user-em-search"
                                        type="text"
                                        class="combobox__input text"
                                    />
                                </div>
                                <button
                                    type="button"
                                    class="combobox__reset"
                                    aria-label="Очистить поле ввода"
                                >
                                    <svg
                                        width="16"
                                        height="16"
                                        viewBox="0 0 16 16"
                                        xmlns="http://www.w3.org/2000/svg"
                                    >
                                        <path
                                            fill-rule="evenodd"
                                            clip-rule="evenodd"
                                            d="M8 15C11.866 15 15 11.866 15 8C15 4.13401 11.866 1 8 1C4.13401 1 1 4.13401 1 8C1 11.866 4.13401 15 8 15ZM8 6.727L10.4657 4.26022C10.8172 3.90875 11.387 3.90875 11.7385 4.26022C12.09 4.6117 12.09 5.18154 11.7385 5.53302L9.272 8.001L11.7385 10.47C12.09 10.8215 12.09 11.3913 11.7385 11.7428C11.387 12.0943 10.8172 12.0943 10.4657 11.7428L8 9.275L5.5357 11.7428C5.18423 12.0943 4.61438 12.0943 4.26291 11.7428C3.91144 11.3913 3.91144 10.8215 4.26291 10.47L6.728 8.001L4.26291 5.53302C3.91144 5.18154 3.91144 4.6117 4.26291 4.26022C4.61438 3.90875 5.18423 3.90875 5.5357 4.26022L8 6.727Z"
                                        />
                                    </svg>
                                </button>
                            </div>
                            <div class="combobox__dropdown-content with-custom-scrollbar">
                                <ul class="combobox__dropdown-content__list"></ul>
                            </div>
                            <button
                                type="button"
                                class="combobox__dropdown"
                                aria-label="Открыть выпадающий список"
                            >
                                <svg
                                    width="16"
                                    height="16"
                                    viewBox="0 0 16 16"
                                    xmlns="http://www.w3.org/2000/svg"
                                >
                                    <path d="M3.5 6L8 11L12.5 6H3.5Z" />
                                </svg>
                            </button>
                        </div>
                    </div>
                    <div
                        class="registration-event-form__item registration-event-form__combobox registration-event-form__combobox_type_not-em"
                    >
                        <label for="user-search" class="registration-event-form__label text-1"
                            >Не сотрудники Компании</label
                        >
                        <div class="combobox">
                            <div class="combobox__inner">
                                <div class="combobox__content">
                                    <input
                                        name="user-search"
                                        id="user-unem-search"
                                        type="text"
                                        class="combobox__input text"
                                    />
                                </div>
                                <button
                                    type="button"
                                    class="combobox__reset"
                                    aria-label="Очистить поле ввода"
                                >
                                    <svg
                                        width="16"
                                        height="16"
                                        viewBox="0 0 16 16"
                                        xmlns="http://www.w3.org/2000/svg"
                                    >
                                        <path
                                            fill-rule="evenodd"
                                            clip-rule="evenodd"
                                            d="M8 15C11.866 15 15 11.866 15 8C15 4.13401 11.866 1 8 1C4.13401 1 1 4.13401 1 8C1 11.866 4.13401 15 8 15ZM8 6.727L10.4657 4.26022C10.8172 3.90875 11.387 3.90875 11.7385 4.26022C12.09 4.6117 12.09 5.18154 11.7385 5.53302L9.272 8.001L11.7385 10.47C12.09 10.8215 12.09 11.3913 11.7385 11.7428C11.387 12.0943 10.8172 12.0943 10.4657 11.7428L8 9.275L5.5357 11.7428C5.18423 12.0943 4.61438 12.0943 4.26291 11.7428C3.91144 11.3913 3.91144 10.8215 4.26291 10.47L6.728 8.001L4.26291 5.53302C3.91144 5.18154 3.91144 4.6117 4.26291 4.26022C4.61438 3.90875 5.18423 3.90875 5.5357 4.26022L8 6.727Z"
                                        />
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="registration-event-form__item registration-event-form__selector">
                        <label for="user-search" class="registration-event-form__label text-1"
                            >Выбор времени для записи</label
                        >
                        <div class="selector">
                            <div class="selector__header">
                                <div class="selector__header-inner">
                                    <span class="selector__title text-1"></span>
                                </div>

                                <button
                                    type="button"
                                    class="selector__dropdown"
                                    aria-label="Открыть выпадающий список"
                                >
                                    <svg
                                        width="16"
                                        height="16"
                                        viewBox="0 0 16 16"
                                        xmlns="http://www.w3.org/2000/svg"
                                    >
                                        <path d="M3.5 6L8 11L12.5 6H3.5Z" />
                                    </svg>
                                </button>
                            </div>
                            <div class="selector__dropdown-content with-custom-scrollbar">
                                <ul class="selector__dropdown-content__list"></ul>
                            </div>
                        </div>
                    </div>

                    <div class="registration-event-form__item registration-event-form__checkbox">
                        <label class="ui-checkbox">
                            <input
                                type="checkbox"
                                class="ui-checkbox__input visibility-hidden"
                                name="send-notification"
                                value="on"
                            />
                            <div class="ui-checkbox__check"></div>
                            <div class="ui-checkbox__content">
                                <p class="selector-dropdown-checkbox__name text">
                                    Отправить уведомление
                                </p>
                            </div>
                        </label>
                    </div>
                </div>
            </form>

            <div class="registration-event__footer text-1"></div>
            <div class="registration-event__informer informer">
                <p class="informer__text text-1">sdf</p>
            </div>
            <div class="registration-event__handles">
                <button
                    form="registration-form"
                    type="submit"
                    class="registration-event-form__submit button button_view_primary"
                >
                    Зарегистрировать
                </button>
                <button type="button" class="button button_view_ghost modal-close">Отмена</button>
            </div>
        </div>
    </div>
</div>
<template id="registration-event-form-selector-input">
    <li>
        <label class="selector__dropdown-content-checkbox selector-dropdown-checkbox">
            <input
                type="radio"
                class="selector-dropdown-checkbox__input visibility-hidden"
                name="time"
                value=""
            />
            <div class="selector-dropdown-checkbox__check"></div>
            <div class="selector-dropdown-checkbox__content">
                <p class="selector-dropdown-checkbox__name text"></p>
            </div>
        </label>
    </li>
</template>
<template id="combobox-user-tag">
    <span class="combobox-tag">
        <span class="combobox-tag__avatar">
            <img class="cover-image" src="./images/avatar-default.jpg" alt="" />
            <span class="combobox-tag__avatar-name"></span>
        </span>
        <span class="combobox-tag__info">
            <span class="combobox-tag__name"></span>
            <span class="combobox-tag__mail"></span>
        </span>

        <button type="button" class="combobox-tag__delete">
            <svg width="12" height="12" viewBox="0 0 12 12" xmlns="http://www.w3.org/2000/svg">
                <path
                    d="M2.16258 9.15573L2.84824 9.84958L5.99832 6.69962L9.14758 9.84898L9.14838 9.84978L9.84819 9.14986L6.69823 5.99973L9.84838 2.84969L9.14128 2.14258L5.99895 5.30042L2.84911 2.15041L2.14844 2.84961L5.30077 6.00205L2.16258 9.15573Z"
                />
            </svg>
        </button>
    </span>
</template>
<template id="combobox-user-default-tag">
    <span class="combobox-tag">
        <span class="combobox-tag__avatar combobox-tag__avatar_type_default">
            <img class="cover-image" src="./images/avatar-default.jpg" alt="Аватар" />
            <span class="combobox-tag__avatar-name"></span>
        </span>
        <span class="combobox-tag__info">
            <span class="combobox-tag__name"></span>
        </span>
        <button type="button" class="combobox-tag__delete">
            <svg width="12" height="12" viewBox="0 0 12 12" xmlns="http://www.w3.org/2000/svg">
                <path
                    d="M2.16258 9.15573L2.84824 9.84958L5.99832 6.69962L9.14758 9.84898L9.14838 9.84978L9.84819 9.14986L6.69823 5.99973L9.84838 2.84969L9.14128 2.14258L5.99895 5.30042L2.84911 2.15041L2.14844 2.84961L5.30077 6.00205L2.16258 9.15573Z"
                />
            </svg>
        </button>
    </span>
</template>
<template id="combobox-user-input">
    <li>
        <label class="combobox__dropdown-content-checkbox combobox-dropdown-checkbox">
            <input
                name="employee"
                type="checkbox"
                class="combobox-dropdown-checkbox__input visibility-hidden"
            />
            <div class="combobox-dropdown-checkbox__check"></div>
            <div class="combobox-dropdown-checkbox__content">
                <div class="combobox-dropdown-checkbox__avatar">
                    <img class="cover-image" src="" alt="" />
                    <span class="combobox-dropdown-checkbox__avatar-name"></span>
                </div>
                <div class="combobox-dropdown-checkbox__about">
                    <p class="combobox-dropdown-checkbox__name text"></p>
                    <span class="combobox-dropdown-checkbox__email"></span>
                </div>
            </div>
        </label>
    </li>
</template>
<% } %>

<!-- Event Listing - отдельный элемент с независимым управлением видимостью -->
<% if (isListingVisible) { %>
<ul class="registration-event-list" id="listing-section-container"></ul>

<div
    class="registration-event-list__modal registration-event-list-confirm-modal modal confirm-modal"
>
    <div class="modal__content confirm-modal__modal-content">
        <div class="modal__header">
            <h2 class="modal__title _font-size-l _line-height-small _font-weight-normal">
                Вы подтверждаете отмену записи?
            </h2>
        </div>
        <div class="modal__body friday__modal-body">
            <div class="registration-event-list-confirm-modal__handles">
                <button type="submit" class="button button_view_primary confirm-modal__confirm">
                    Подтвердить
                </button>
                <button type="button" class="modal-close button button_view_ghost">Отмена</button>
            </div>
        </div>
    </div>
</div>
<template id="registration-event-list-item">
    <li class="registration-event-list-item">
        <div class="registration-event-list-item__info">
            <p class="registration-event-list-item__name title-4"></p>
            <p class="registration-event-list-item__time text-3">
                <span class="registration-event-list-item__date"></span>
                <span class="registration-event-list-item__day"></span>
            </p>
        </div>
        <div class="registration-event-list-item__subscriber text-2">
            <p class="registration-event-list-item__subscriber-info"></p>
            <div class="registration-event-list-item__subscriber-user">
                <p class="registration-event-list-item__subscriber-name"></p>
                (<a class="registration-event-list-item__subscriber-link"></a>)
            </div>
        </div>
        <button data-id="button-register" class="button button_view_ghost">Отменить запись</button>
    </li>
</template>
<% } %>

<script>
    // Pass server-side variables to JavaScript
    var EVENT_CONFIG = {
    	mainSiteId: '<%= mainSiteIdStr %>',
    	eventId: '<%= eventId %>',
    	contextPath: '<%= contextPath %>',
    	isConfigured: <%= isConfigured %>,
    	isWidgetVisible: <%= isWidgetVisible %>,
    	isListingVisible: <%= isListingVisible %>
    };

    console.log('Event Widget configuration loaded:', EVENT_CONFIG);
</script>

<script src="<%= contextPath %>/META-INF/resources/js/widget.js"></script>
