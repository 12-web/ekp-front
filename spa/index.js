// пример отправки события

// (function () {
//     window.gpnAnalytics &&
//         window.gpnAnalytics.sendEvent(3, {
//             componentId: "user_login",
//             constaeventtype: "undefined",
//             component: "OTHER",
//             customparams: [{ as_user_id: true, value: "1" }],
//         });
// })();

//Новости

(function () {
    // загрузка страницы новости
    const onLoadNews = () => {
        const customparams = [
            {
                user_id: "",
                user_do: "",
                news_title: "",
                news_id: "",
                news_tag: "",
                content_type: "",
                type_new: "",
                publishdate: "",
            },
        ];

        window.gpnAnalytics &&
            window.gpnAnalytics.sendEvent(3, {
                componentId: "open_new",
                constaeventtype: "undefined",
                component: "OTHER",
                customparams,
            });
    };

    window.addEventListener("load", onLoadNews);

    // нажатие на кнопку лайка
    const likeBtn = document.querySelector(".news-template-assets_likes");

    const handleArrowClick = () => {
        if (!likeBtn) return;

        const customparams = [
            {
                user_id: "",
                user_do: "",
                news_title: "",
                news_id: "+",
                news_tag: "+",
                content_type: "",
                type_new: "",
                type_like: "",
                publishdate: "+",
            },
        ];

        window.gpnAnalytics &&
            window.gpnAnalytics.sendEvent(3, {
                componentId: "news_like_pressed",
                constaeventtype: "undefined",
                component: "OTHER",
                customparams,
            });
    };

    likeBtn?.addEventListener("click", handleArrowClick);

    //Нажатие на теги новостей
    const tagsContainer = document.querySelector(".news-template-tags-items");

    const handleTagsClick = (e) => {
        const tag = e?.target.closest(".news-template-tags-item");

        if (!tag) return;

        window.gpnAnalytics &&
            window.gpnAnalytics.sendEvent(3, {
                componentId: "news_tag_pressed",
                constaeventtype: "undefined",
                component: "OTHER",
                customparams: [
                    {
                        user_id: "",
                        user_do: "",
                        tag: "",
                        page: "",
                        location_tag: "",
                        action_tag: "",
                    },
                ],
            });
    };

    tagsContainer?.addEventListener("click", handleTagsClick);

    //Скролл до конца новости
    const depthValue = 0.9;
    let depthGoal = true;

    const handleScrollEnd = () => {
        if (!depthGoal) return;

        const isCompleteDepth =
            document.documentElement.scrollHeight -
                document.documentElement.scrollTop -
                document.documentElement.clientHeight <
            document.documentElement.scrollHeight * (1 - depthValue);

        if (isCompleteDepth) {
            window.gpnAnalytics &&
                window.gpnAnalytics.sendEvent(3, {
                    componentId: "finish_new",
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
                        },
                    ],
                });
            depthGoal = false;
        }
    };

    window.addEventListener("scroll", handleScrollEnd);
})();
