<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/portlet_2_0" prefix="portlet" %> <%@ taglib
uri="http://liferay.com/tld/aui" prefix="aui" %> <%@ taglib uri="http://liferay.com/tld/portlet"
prefix="liferay-portlet" %> <%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>

<liferay-theme:defineObjects />
<portlet:defineObjects />

<%@ include file="/META-INF/resources/init.jsp" %> <%@ page
import="com.liferay.portal.kernel.util.PortalUtil" %> <%@ page
import="com.liferay.portal.kernel.exception.PortalException" %> <%@ page
import="com.liferay.portal.kernel.model.User" %> <%@ page contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <% // Получаем настройки из атрибутов, установленных в Java классе String
mainSiteIdStr = (String) renderRequest.getAttribute("mainSiteId"); String eventId = (String)
renderRequest.getAttribute("eventId"); Boolean isConfigured = (Boolean)
renderRequest.getAttribute("isConfigured"); if (mainSiteIdStr == null) mainSiteIdStr = ""; if
(eventId == null) eventId = ""; if (isConfigured == null) isConfigured = false; long effectiveSiteId
= themeDisplay.getScopeGroupId(); if (!mainSiteIdStr.isEmpty()) { effectiveSiteId =
Long.parseLong(mainSiteIdStr); } long siteId = 0; long companyId = 0; long currentUserId = 0; String
contextPath = request.getContextPath(); try { siteId = PortalUtil.getScopeGroupId(request);
companyId = PortalUtil.getCompanyId(request); User user1 = PortalUtil.getUser(request); if (user1 !=
null) { currentUserId = user1.getUserId(); } siteId = effectiveSiteId; } catch (PortalException e) {
throw new RuntimeException(e); } %>

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

    .combobox__dropdown-content:has(> .combobox__dropdown-content__list:empty) + .combobox__dropdown {
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

    .selector-dropdown-checkbox__input[type="checkbox"] + .selector-dropdown-checkbox__check::before {
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


          /* Стили для формы настройки */
          .event-widget__config-form {
          	position: relative;
          	z-index: 10;
          	background: rgba(255, 255, 255, 0.95);
          	border-radius: 12px;
          	padding: 20px;
          	backdrop-filter: blur(10px);
          }

          .event-widget__form-title {
          	font-size: 20px;
          	font-weight: 600;
          	margin: 0 0 20px 0;
          	color: #333;
          	text-align: center;
          }

          .event-widget__form-group {
          	margin-bottom: 16px;
          }

          .event-widget__form-label {
          	display: block;
          	font-size: 14px;
          	font-weight: 500;
          	margin-bottom: 6px;
          	color: #333;
          }

          .event-widget__form-input {
          	width: 100%;
          	padding: 10px 12px;
          	border: 1px solid #ddd;
          	border-radius: 8px;
          	font-size: 14px;
          	box-sizing: border-box;
          	transition: border-color 0.3s;
          }

          .event-widget__form-input:focus {
          	outline: none;
          	border-color: #667eea;
          	box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
          }

          .event-widget__form-button {
          	width: 100%;
          	padding: 12px;
          	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          	color: white;
          	border: none;
          	border-radius: 8px;
          	font-size: 16px;
          	font-weight: 500;
          	cursor: pointer;
          	transition: transform 0.3s;
          }

          .event-widget__form-button:hover {
          	transform: translateY(-2px);
          }

          .event-widget__form-button:disabled {
          	background: #ccc;
          	cursor: not-allowed;
          	transform: none;
          }

          /* Стили для сообщений */
          .alert {
          	padding: 12px 16px;
          	border-radius: 8px;
          	margin-bottom: 16px;
          	font-size: 14px;
          }

          .alert-error {
          	background: #ffe6e6;
          	border: 1px solid #ff6b6b;
          	color: #d00000;
          }

          .alert-success {
          	background: #e6ffe6;
          	border: 1px solid #4caf50;
          	color: #2e7d32;
          }

          /* Скрытие элементов */
          .widget-main-content {
          	display: <%= isConfigured ? "flex" : "none" %>;
          	flex-direction: column;
          	width: 100%;
          }

          .widget-config-content {
          	display: <%= !isConfigured ? "block" : "none" %>;
          	width: 100%;
          }
</style>

<div class="event-widget">
    <img
        class="event-widget__bg"
        src="<%= contextPath %>/META-INF/resources/images/event-bg.jpg"
        alt="Фон события"
    />

    <!-- Форма конфигурации (показывается только если виджет не настроен) -->
    <div class="widget-config-content">
        <div class="event-widget__config-form">
            <h3 class="event-widget__form-title">Настройка виджета регистрации на событие</h3>

            <!-- Сообщения об ошибках -->
            <c:if test="${not empty emptyMainSiteId}">
                <div class="alert alert-error">${emptyMainSiteId}</div>
            </c:if>
            <c:if test="${not empty emptyButtonUrl}">
                <div class="alert alert-error">${emptyButtonUrl}</div>
            </c:if>
            <c:if test="${not empty invalidSiteId}">
                <div class="alert alert-error">${invalidSiteId}</div>
            </c:if>
            <c:if test="${not empty saveError}">
                <div class="alert alert-error">${saveError}</div>
            </c:if>

            <!-- Сообщение об успехе -->
            <c:if test="${not empty preferencesSaved}">
                <div class="alert alert-success">${preferencesSaved}</div>
                <script>
                    // Автоматическое обновление страницы через 1 секунду после успешного сохранения
                    setTimeout(function () {
                        window.location.reload();
                    }, 1000);
                </script>
            </c:if>

            <form action="<%= savePreferencesURL %>" method="post" name="configForm">
                <input type="hidden" name="action" value="savePreferences" />

                <div class="event-widget__form-group">
                    <label class="event-widget__form-label" for="mainSiteId"
                        >ID основного сайта:</label
                    >
                    <input
                        type="text"
                        id="mainSiteId"
                        name="<portlet:namespace />mainSiteId"
                        class="event-widget__form-input"
                        placeholder="Введите ID сайта (только цифры)"
                        value="<%= mainSiteIdStr %>"
                        required
                        pattern="[0-9]+"
                    />
                </div>

                <div class="event-widget__form-group">
                    <label class="event-widget__form-label" for="eventId">ID события:</label>
                    <input
                        type="text"
                        id="eventId"
                        name="<portlet:namespace />eventId"
                        class="event-widget__form-input"
                        placeholder="Введите ID события"
                        value="<%= eventId %>"
                        required
                    />
                </div>

                <button type="submit" class="event-widget__form-button">Сохранить настройки</button>
            </form>
        </div>
    </div>

    <!-- Основной контент виджета (показывается только после настройки) -->
    <div class="widget-main-content">
        <% if (isConfigured) { %>
        <button
            data-modal="registration-event-modal"
            type="button"
            class="button button_view_primary"
        >
            Открыть
        </button>
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
                                <img
                                    src="./images/time.svg"
                                    class="registration-event__info-icon"
                                />
                                <div>
                                    <p class="title-4 registration-event__date"></p>
                                    <p class="text-1 registration-event__day"></p>
                                </div>
                            </div>
                            <div class="registration-event__info-col">
                                <img
                                    src="./images/user.svg"
                                    class="registration-event__info-icon"
                                />
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
                            <p class="title-3 registration-event__parts-title">
                                Участники мероприятия
                            </p>
                            <div
                                class="registration-event-form__item registration-event-form__combobox registration-event-form__combobox_type_em"
                            >
                                <label
                                    for="user-search"
                                    class="registration-event-form__label text-1"
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
                                <label
                                    for="user-search"
                                    class="registration-event-form__label text-1"
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
                            <div
                                class="registration-event-form__item registration-event-form__selector"
                            >
                                <label
                                    for="user-search"
                                    class="registration-event-form__label text-1"
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

                            <div
                                class="registration-event-form__item registration-event-form__checkbox"
                            >
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
                        <button type="button" class="button button_view_ghost modal-close">
                            Отмена
                        </button>
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
                    <svg
                        width="12"
                        height="12"
                        viewBox="0 0 12 12"
                        xmlns="http://www.w3.org/2000/svg"
                    >
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
                    <svg
                        width="12"
                        height="12"
                        viewBox="0 0 12 12"
                        xmlns="http://www.w3.org/2000/svg"
                    >
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
    </div>
</div>

<script>
    // Pass server-side variables to JavaScript
    var EVENT_CONFIG = {
    	siteId: <%= siteId %>,
    	companyId: <%= companyId %>,
    	currentUserId: <%= currentUserId %>,
    	contextPath: '<%= contextPath %>',
    	eventId: '<%= eventId %>',
    	baseURL: '/o/event-registration-api',
    	isConfigured: <%= isConfigured %>
    };

    console.log('Event Widget configuration loaded:', EVENT_CONFIG);
</script>

<script src="<%= contextPath %>/META-INF/resources/js/event-widget.js"></script>
