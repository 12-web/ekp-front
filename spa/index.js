// пример отправки события

(function () {
    window.gpnAnalytics &&
        window.gpnAnalytics.sendEvent(3, {
            componentId: "user_login",
            constaeventtype: "undefined",
            component: "OTHER",
            customparams: [{ as_user_id: true, value: "1" }],
        });
})();

//Новости

(function () {
    // нажатие на кнопки переключения новостей
    const arrowBtnContainer = document.querySelector(".arrow-btn-container");

    const handleArrowClick = (e) => {
        const btn = e.target.closest("button");

        if (!e || !btn) return;

        window.gpnAnalytics &&
            window.gpnAnalytics.sendEvent(3, {
                componentId: "interaction_with_the_new",
                constaeventtype: "undefined",
                component: "OTHER",
                customparams: [
                    {
                        user_id: "",
                        user_do: "",
                        news_title: "",
                        news_id: "",
                        news_tag: "",
                        content_type: "",
                        type_new: "",
                        publishdate: "",
                        interaction: "",
                    },
                ],
            });
    };

    arrowBtnContainer?.addEventListener("click", handleArrowClick);
})();
