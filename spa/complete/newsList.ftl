<#if !entries?has_content>
    <div class="alert alert-info text-center no-results-alert">
        Нет данных для отображения
    </div>
</#if>

<#setting locale="ru_RU">
<#assign assetEntryLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetEntryLocalService")>
<#assign dlFileEntryLocalService = serviceLocator.findService("com.liferay.document.library.kernel.service.DLFileEntryLocalService")>
<#assign DDMStructureLocalService = serviceLocator.findService("com.liferay.dynamic.data.mapping.service.DDMStructureLocalService")>
<#assign assetVocabularyLocalServiceUtil = staticUtil["com.liferay.asset.kernel.service.AssetVocabularyLocalServiceUtil"]>

<#function getArticleDLEntryUrl xmlValue>
	<#local docUrl = "" />
    <#if xmlValue?has_content>
        <#local jsonObject = jsonFactoryUtil.createJSONObject(xmlValue) />
        <#local entryUuid = jsonObject.uuid />
        <#local entryGroupId = getterUtil.getLong(jsonObject.groupId) />
        <#if dlFileEntryLocalService.fetchDLFileEntryByUuidAndGroupId(entryUuid, entryGroupId)?has_content>
            <#local dlFileEntry = dlFileEntryLocalService.fetchDLFileEntryByUuidAndGroupId(entryUuid, entryGroupId) />
            <#if !dlFileEntry.isInTrash()>
                <#local assetEntry = assetEntryLocalService.getEntry("com.liferay.document.library.kernel.model.DLFileEntry", dlFileEntry.fileEntryId) />
                <#local assetRenderer = assetEntry.assetRenderer />
                <#local docUrl = assetRenderer.getURLDownload(themeDisplay) />
            </#if>
        </#if>
    </#if>
    <#return docUrl />
</#function>

<#function getVocabularyName category>
    <#assign categoryVocab = category.vocabularyId />
    <#assign vocabulary = assetVocabularyLocalServiceUtil.getAssetVocabulary(categoryVocab)>
    <#assign vocabularyName = vocabulary.getName()>

    <#return vocabularyName>
</#function>

<#function isMainCategory categories>
    <#list categories as category>
        <#assign vocabularyName = getVocabularyName(category)>

        <#if vocabularyName == "отображение в виджетах">
            <#return true>
        </#if>
    </#list>

    <#return false>
</#function>

<#macro getCategory categories theme>
    <#list categories as category>
        <#assign vocabularyName = getVocabularyName(category)>

        <#if vocabularyName = theme>
            <span class="publications__category">${category.name}</span>
        </#if>
    </#list>
</#macro>

<#macro renderCategories categories theme>
    <#if isMainCategory(categories)>
        <@getCategory categories "отображение в виджетах" />
    <#else>
        <@getCategory categories theme />
    </#if>
</#macro>

<#if entries?has_content>
    <div class="publications">
        <div class="publications__container">
            <#list entries as curEntry>
                <#if curEntry.getAssetRenderer().getClassName()?contains("JournalArticle")>
                    <#assign assetRenderer = curEntry.getAssetRenderer() />
                    <#assign viewUrl = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, assetRenderer, curEntry, true) />
                    <#assign docXml = saxReaderUtil.read(curEntry.getAssetRenderer().getArticle().getContent()) />
                    <#assign fieldValImage = docXml.valueOf( "//dynamic-element[@name='image']/dynamic-content/text()") />
                    <#assign fieldValImageURL = getArticleDLEntryUrl(fieldValImage)>
                    <#assign fieldValText = docXml.valueOf( "//dynamic-element[@name='text']/dynamic-content/text()") />
                    <#assign fieldValDate = docXml.valueOf( "//dynamic-element[@name='date']/dynamic-content/text()") />
                    <#assign fieldValTime = docXml.valueOf( "//dynamic-element[@name='time']/dynamic-content/text()") />
                    <#assign structureName = DDMStructureLocalService.getStructure(themeDisplay.getCompanyGroupId(), curEntry.getClassNameId(), curEntry.getAssetRenderer().getArticle().getDDMStructureKey()).getName(locale)>
                    <#assign categories = curEntry.getCategories()>

                    <div class="publications__item">
                        <#if fieldValImage?has_content && fieldValImageURL?has_content>
                            <a href="${viewUrl}" class="publications__image" style="background-image: url('${fieldValImageURL}');"></a>
                        <#elseif structureName = "Объявление">
                            <#assign gradientBg = "#0097d8, #3fbfad" />

                            <#if categories?has_content>
                                <#list categories as category>
                                    <#if getVocabularyName(category) = "тематика объявлений">
                                        <#assign description = category.getDescription(locale)>

                                        <#if description?has_content>
                                            <#assign gradientBg = description />
                                        </#if>
                                    </#if>
                                </#list>
                            </#if>

                            <a href="${viewUrl}" style="background: linear-gradient(135deg, ${gradientBg});" class="publications__image">
                                <#if fieldValDate?has_content>
                                    <span>${fieldValDate?datetime("yyyy-MM-dd")?string("d MMMM")}</span>
                                </#if>
                                <#if fieldValTime?has_content>
                                    <span class="publications__image-time">${fieldValTime}</span>
                                </#if>
                            </a>
                        </#if>

                        <div class="publications__description">
                            <#if structureName = "Новости">
                                <div class="publications__categories">
                                    <#if categories?has_content>
                                        <@renderCategories categories "тематика новостей" />
                                    </#if>
                                </div>
                            <#elseif structureName = "Новости компании">
                                <div class="publications__categories">
                                    <#if categories?has_content>
                                        <@renderCategories categories "тематика новостей компании" />
                                    </#if>
                                </div>
                            <#elseif structureName = "Объявление">
                                <#if fieldValDate?has_content>
                                    <div class="publications__event">
                                        <#if fieldValTime?has_content>
                                            <span class="publications__event-time">${fieldValTime} /</span>
                                        </#if>
                                        <span class="publications__event-date">
                                            ${fieldValDate?datetime("yyyy-MM-dd")?string("d MMMM")}
                                        </span>
                                        <span class="publications__event-day">
                                            ${fieldValDate?datetime("yyyy-MM-dd")?string("EEE")}
                                        </span>
                                    </div>
                                </#if>
                            </#if>

                            <div class="publications__title">
                                <a href="${viewUrl}">${stringUtil.shorten(htmlUtil.stripHtml(curEntry.getTitle(locale)), 150)}</a>
                            </div>

                            <div class="publications__info">
                                <span class="publications__date">${curEntry.getPublishDate()?string("d MMMM")}</span>
                                <#if metadataFields?contains("view-count")>
                                    <span class="publications__views">${curEntry.getViewCount()}</span>
                                </#if>
                                <#if (enableRatings == "true")>
                                    <span class="publications__ratings">
                                        <@liferay_ui["ratings"]
                                            className=curEntry.getClassName()
                                            classPK=curEntry.getClassPK()
                                            type="like"
                                        />
                                    </span>
                                </#if>
                            </div>
                        </div>
                    </div>
                </#if>
            </#list>
            <div class="publications__item-hidden"></div>
            <div class="publications__switch-mode" onClick="switchMode(event)">
                <button name="tiles"></button>
                <button name="list"></button>
            </div>
        </div>
        <#if entries?has_content>
            <div class="publications__button">
                <button class="btn show-publications-more btn-secondary">
                    Ещё
                </button>
            </div>
        </#if>
    </div>
</#if>

<script>
  // === SPA ===
  (function () {
    // utils
    const sendSPA = (params) => {
        if (window.gpnAnalytics) {
            window.gpnAnalytics.sendEvent(3, params);
        }
    };

    const getCurrentUser = async () => {
      const res = await fetch('/o/headless-admin-user/v1.0/my-user-account', {
            headers: {
                "X-CSRF-Token": "Liferay.authToken", // раскомментить при переносе
            },
        });
      return await res.json();
    }

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
</script>
