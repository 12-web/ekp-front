(function () {
    // Mock data
    const mockUserEventsData = {
        data: {
            currentPage: 1,
            totalPages: 10,
            pageSize: 10,
            totalCount: 100,
            items: [
                {
                    eventId: "47421",
                    name: "Ежегодная встреча теней",
                    date: "28.01.2026",
                },
            ],
        },
        response: {
            code: 200,
            status: "success",
            message: "SUCCESS",
            timestamp: new Date().toISOString(),
        },
        context: {
            companyId: "20097",
            currentUserId: "38201",
            siteId: "20121",
        },
    };

    const generateMockData = (page) => {
        return {
            data: {
                currentPage: page,
                totalPages: 10,
                pageSize: 10,
                totalCount: 100,
                items: Array.from({ length: 10 }, (_, i) => ({
                    eventId: `${47421 + (page - 1) * 10 + i}`,
                    name: `Событие ${(page - 1) * 10 + i + 1}`,
                    date: new Date(2026, 0, 28 + (page - 1) * 7).toLocaleDateString("ru-RU"),
                })),
            },
            response: {
                code: 200,
                status: "success",
                message: "SUCCESS",
                timestamp: new Date().toISOString(),
            },
            context: {
                companyId: "20097",
                currentUserId: "38201",
                siteId: "20121",
            },
        };
    };

    // API
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
            if (!window.EVENT_CONFIG) return {};

            return {
                siteId: window.EVENT_CONFIG?.siteId || "",
                companyId: window.EVENT_CONFIG?.companyId || "",
                currentUserId: window.EVENT_CONFIG?.currentUserId || "",
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

        getUserEvents(page = 1, pageSize = 10) {
            // Mock data для разработки
            // Для переключения на реальный API установите window.EVENT_CONFIG.useMock = false
            const useMock = window.EVENT_CONFIG?.useMock !== false;

            if (useMock) {
                return new Promise((resolve) => {
                    setTimeout(() => {
                        resolve(generateMockData(page));
                    }, 300); // Имитация задержки сети
                });
            }

            // Реальный API запрос
            return this._request("/user-events", {
                method: "POST",
                headers: this._headers,
                body: JSON.stringify({
                    data: {
                        page,
                        pageSize,
                    },
                    ...this._getDefaultParams(),
                }),
            });
        }
    }

    // Component
    class Pagination {
        constructor(root) {
            this._root = root;
            this._prevButton = this._root.querySelector(".pagination__button--prev");
            this._nextButton = this._root.querySelector(".pagination__button--next");
            this._list = this._root.querySelector(".pagination__list");

            this._currentPage = 1;
            this._totalPages = 1;
            this._isLoading = false;

            this._onPrevClick = this._onPrevClick.bind(this);
            this._onNextClick = this._onNextClick.bind(this);
            this._onPageClick = this._onPageClick.bind(this);

            this._api = new EventsApi({
                headers: {
                    "Content-Type": "application/json",
                },
                baseUrl: window.EVENT_CONFIG?.baseURL || "./o/events",
            });

            this.init();
        }

        init() {
            this._setEventListeners();
            this._loadPage(this._currentPage);
        }

        _setEventListeners() {
            this._prevButton?.addEventListener("click", this._onPrevClick);
            this._nextButton?.addEventListener("click", this._onNextClick);
            this._list?.addEventListener("click", this._onPageClick);
        }

        _onPrevClick(e) {
            e?.preventDefault();

            if (this._isLoading || this._currentPage <= 1) return;

            this._loadPage(this._currentPage - 1);
        }

        _onNextClick(e) {
            e?.preventDefault();

            if (this._isLoading || this._currentPage >= this._totalPages) return;

            this._loadPage(this._currentPage + 1);
        }

        _onPageClick(e) {
            const button = e?.target.closest(".pagination__link");

            if (!button || button.disabled) return;

            const page = Number(button.dataset.page);

            if (!page || page === this._currentPage) return;

            e.preventDefault();
            this._loadPage(page);
        }

        _setLoading(isLoading) {
            this._isLoading = isLoading;

            const buttons = this._root.querySelectorAll("button");
            buttons.forEach((button) => {
                button.disabled = isLoading;
            });
        }

        async _loadPage(page) {
            if (this._isLoading) return;

            this._setLoading(true);

            try {
                const data = await this._api.getUserEvents(page);

                if (data?.response?.status === "success") {
                    // Поддержка разных форматов ответа API
                    this._currentPage = 
                        data?.data?.currentPage || 
                        data?.data?.page || 
                        data?.page || 
                        page;
                    
                    this._totalPages = 
                        data?.data?.totalPages || 
                        data?.data?.lastPage || 
                        data?.lastPage || 
                        1;

                    this._render();
                    this._updateButtons();
                } else {
                    console.error("Ошибка загрузки данных:", data?.response?.message);
                }
            } catch (err) {
                console.error("Ошибка при загрузке страницы:", err);
            } finally {
                this._setLoading(false);
            }
        }

        _render() {
            if (!this._list) return;

            this._list.innerHTML = "";

            const pages = this._generatePages(this._currentPage, this._totalPages);

            pages.forEach((pageData) => {
                const li = document.createElement("li");
                li.className = "pagination__item";

                if (pageData.type === "dots") {
                    li.classList.add("pagination__item--dots");
                    const span = document.createElement("span");
                    span.className = "pagination__dots";
                    span.textContent = "...";
                    li.appendChild(span);
                } else {
                    if (pageData.page === this._currentPage) {
                        li.classList.add("pagination__item--active");
                    }

                    const button = document.createElement("button");
                    button.type = "button";
                    button.className = "pagination__link";
                    button.dataset.page = pageData.page;
                    button.setAttribute("aria-label", `Страница ${pageData.page}`);
                    button.textContent = pageData.page;

                    if (pageData.page === this._currentPage) {
                        button.setAttribute("aria-current", "page");
                    }

                    li.appendChild(button);
                }

                this._list.appendChild(li);
            });
        }

        _generatePages(currentPage, totalPages) {
            const pages = [];
            const maxVisible = 7;
            const sidePages = 2;

            if (totalPages <= maxVisible) {
                for (let i = 1; i <= totalPages; i++) {
                    pages.push({ type: "page", page: i });
                }
            } else {
                if (currentPage <= sidePages + 2) {
                    for (let i = 1; i <= sidePages + 3; i++) {
                        pages.push({ type: "page", page: i });
                    }
                    pages.push({ type: "dots" });
                    pages.push({ type: "page", page: totalPages });
                } else if (currentPage >= totalPages - sidePages - 1) {
                    pages.push({ type: "page", page: 1 });
                    pages.push({ type: "dots" });
                    for (let i = totalPages - sidePages - 2; i <= totalPages; i++) {
                        pages.push({ type: "page", page: i });
                    }
                } else {
                    pages.push({ type: "page", page: 1 });
                    pages.push({ type: "dots" });
                    for (let i = currentPage - sidePages; i <= currentPage + sidePages; i++) {
                        pages.push({ type: "page", page: i });
                    }
                    pages.push({ type: "dots" });
                    pages.push({ type: "page", page: totalPages });
                }
            }

            return pages;
        }

        _updateButtons() {
            if (this._prevButton) {
                this._prevButton.disabled = this._currentPage <= 1 || this._isLoading;
            }

            if (this._nextButton) {
                this._nextButton.disabled = this._currentPage >= this._totalPages || this._isLoading;
            }
        }
    }

    // Init
    const paginationEl = document.querySelector(".pagination");
    if (paginationEl) {
        new Pagination(paginationEl);
    }
})();
