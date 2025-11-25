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
    // utils
    const sendSPA = (params) => {
        if (window.gpnAnalytics) {
            window.gpnAnalytics.sendEvent(3, params);
        }
    };

    // api
    const getCurrentUser = async () => {
        const res = await fetch("https://api.escuelajs.co/api/v1/users/1", {
            headers: {
                "X-CSRF-Token": "Liferay.authToken", // раскомментить при переносе
            },
        });
        return await res.json();
    };

    const isAnnouncement = window.location.pathname.match(/vse-objhhjavlenija/g);
    const isСorporateNew = window.location.pathname.match(/novosti-kompanii/g);

    //Страница новости открылась у пользователя
    const onLoadNews = async () => {
        try {
            const currentUser = await getCurrentUser();

            const customparams = [
                {
                    user_id: currentUser?.name || "",
                    user_do: currentUser?.organizationBriefs?.name || "",
                    news_title: "",
                    news_id: "",
                    news_tag: "",
                    content_type: isСorporateNew ? "корпоративная новость" : "новость ДО",
                    type_new: isAnnouncement ? "объявление" : "новость",
                    publishdate: "",
                },
            ];

            sendSPA({
                componentId: "open_new",
                constaeventtype: "undefined",
                component: "OTHER",
                customparams,
            });
        } catch {}
    };

    window.addEventListener("load", onLoadNews);

    //Отметка лайк на новости
    const likeBtn = document.querySelector(".news-template-assets_likes");

    const handleLikeClick = async () => {
        if (!likeBtn) return;

        try {
            const currentUser = await getCurrentUser();

            const customparams = [
                {
                    user_id: currentUser?.name || "",
                    user_do: currentUser?.organizationBriefs?.name || "",
                    news_title: "",
                    news_id: "+",
                    news_tag: "+",
                    content_type: isСorporateNew ? "корпоративная новость" : "новость ДО",
                    type_new: isAnnouncement ? "объявление" : "новость",
                    type_like: "",
                    publishdate: "+",
                },
            ];

            sendSPA({
                componentId: "news_like_pressed",
                constaeventtype: "undefined",
                component: "OTHER",
                customparams,
            });
        } catch {}
    };

    likeBtn?.addEventListener("click", handleLikeClick);

    //Выбор тега новостей
    const tagsContainer = document.querySelector(".news-template-tags-items");

    const handleTagsClick = async (e) => {
        const tag = e?.target.closest(".news-template-tags-item");

        if (!tag) return;

        try {
            const currentUser = await getCurrentUser();

            const customparams = [
                {
                    user_id: currentUser?.name || "",
                    user_do: currentUser?.organizationBriefs?.name || "",
                    tag: "",
                    page: document.title,
                    location_tag: "",
                    action_tag: "",
                },
            ];

            sendSPA({
                componentId: "news_tag_pressed",
                constaeventtype: "undefined",
                component: "OTHER",
                customparams,
            });
        } catch {}
    };

    tagsContainer?.addEventListener("click", handleTagsClick);

    //Скролл до конца новости
    const depthValue = 0.9;
    let depthGoal = true;

    const handleScrollEnd = async () => {
        if (!depthGoal) return;

        const isCompleteDepth =
            document.documentElement.scrollHeight -
                document.documentElement.scrollTop -
                document.documentElement.clientHeight <
            document.documentElement.scrollHeight * (1 - depthValue);

        if (isCompleteDepth) {
            depthGoal = false;

            try {
                const currentUser = await getCurrentUser();

                const customparams = [
                    {
                        user_id: currentUser?.name || "",
                        user_do: currentUser?.organizationBriefs?.name || "",
                        news_title: "",
                        news_id: "",
                        news_tag: "",
                        content_type: isСorporateNew ? "корпоративная новость" : "новость ДО",
                        type_new: isAnnouncement ? "объявление" : "новость",
                        publishdate: "",
                    },
                ];

                sendSPA({
                    componentId: "finish_new",
                    constaeventtype: "undefined",
                    component: "OTHER",
                    customparams,
                });
            } catch {}
        }
    };

    window.addEventListener("scroll", handleScrollEnd);

    // Галерея в новости

    // Стрелки карусели
    const nextGalleryBtn = document.querySelector(".img-next-button");
    const prevGalleryBtn = document.querySelector(".img-prev-button");

    const handleNavGalleryClick = async () => {
        try {
            const currentUser = await getCurrentUser();

            const customparams = [
                {
                    user_id: currentUser?.name || "",
                    user_do: currentUser?.organizationBriefs?.name || "",
                    news_title: "",
                    news_id: "",
                    news_tag: "",
                    content_type: isСorporateNew ? "корпоративная новость" : "новость ДО",
                    type_new: isAnnouncement ? "объявление" : "новость",
                    publishdate: "",
                    interaction: "стрелка карусели",
                },
            ];

            sendSPA({
                componentId: "interaction_with_the_new",
                constaeventtype: "undefined",
                component: "OTHER",
                customparams,
            });
        } catch {}
    };

    nextGalleryBtn?.addEventListener("click", handleNavGalleryClick);
    prevGalleryBtn?.addEventListener("click", handleNavGalleryClick);

    //Пользователь увеличил фото или нажал на видел
    const mediaGallery = document.querySelector(".image-viewer-base-image-list");

    const handleMediaGalleryClick = async (e) => {
        const isImg = !!e?.target.closest("img");
        const isVideo = !!e?.target.closest("video");

        try {
            const currentUser = await getCurrentUser();

            const customparams = [
                {
                    user_id: currentUser?.name || "",
                    user_do: currentUser?.organizationBriefs?.name || "",
                    news_title: "",
                    news_id: "",
                    news_tag: "",
                    content_type: isСorporateNew ? "корпоративная новость" : "новость ДО",
                    type_new: isAnnouncement ? "объявление" : "новость",
                    publishdate: "",
                    interaction: isImg ? "увеличение фотографии" : isVideo ? "play видео" : "",
                },
            ];

            sendSPA({
                componentId: "interaction_with_the_new",
                constaeventtype: "undefined",
                component: "OTHER",
                customparams,
            });
        } catch {}
    };

    mediaGallery?.addEventListener("click", handleMediaGalleryClick);

    // Пользователь нажал значок фото или видео в карусели
    const menuGallery = document.querySelector(".carousel-menu");

    const handleMenuGalleryClick = async (e) => {
        const media = e?.target.closest(".carousel-menu-index");

        if (!media) return;

        try {
            const currentUser = await getCurrentUser();

            const customparams = [
                {
                    user_id: currentUser?.name || "",
                    user_do: currentUser?.organizationBriefs?.name || "",
                    news_title: "",
                    news_id: "",
                    news_tag: "",
                    content_type: isСorporateNew ? "корпоративная новость" : "новость ДО",
                    type_new: isAnnouncement ? "объявление" : "новость",
                    publishdate: "",
                    interaction: "виджет карусели",
                },
            ];

            sendSPA({
                componentId: "interaction_with_the_new",
                constaeventtype: "undefined",
                component: "OTHER",
                customparams,
            });
        } catch {}
    };

    menuGallery?.addEventListener("click", handleMenuGalleryClick);

    //Пользователь нажал на ссылку внтури страницы новости
    const articleTextContainer = document.querySelector(".news-template-text");

    const handleLinkClick = async (e) => {
        const link = !!e?.target.closest("a");

        if (!link) return;

        try {
            const currentUser = await getCurrentUser();

            const customparams = [
                {
                    user_id: currentUser?.name || "",
                    user_do: currentUser?.organizationBriefs?.name || "",
                    news_title: "",
                    news_id: "",
                    news_tag: "",
                    content_type: isСorporateNew ? "корпоративная новость" : "новость ДО",
                    type_new: isAnnouncement ? "объявление" : "новость",
                    publishdate: "",
                    interaction: "ссылка",
                },
            ];

            sendSPA({
                componentId: "interaction_with_the_new",
                constaeventtype: "undefined",
                component: "OTHER",
                customparams,
            });
        } catch {}
    };

    articleTextContainer?.addEventListener("click", handleLinkClick);

    //Нажатие на теги новостей
    const tagsListContainer = document.querySelector(".tag-list");

    const handleTagsListClick = async (e) => {
        const tag = e?.target.closest(".tag");

        if (!tag) return;

        const currentUser = await getCurrentUser();

        sendSPA({
            componentId: "news_tag_pressed",
            constaeventtype: "undefined",
            component: "OTHER",
            customparams: [
                {
                    user_id: currentUser?.name || "",
                    user_do: currentUser?.organizationBriefs?.name || "",
                    tag: tag.textContent,
                    page: document.title,
                    location_tag: "категория новостей",
                    action_tag: "выбрал тег",
                },
            ],
        });
    };

    tagsListContainer?.addEventListener("click", handleTagsListClick);
})();
