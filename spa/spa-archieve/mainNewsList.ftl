<#if !entries?has_content>
    <div class="alert alert-info text-center no-results-alert">
		Нет данных для отображения
	</div>
</#if>

<#setting locale="ru_RU">
<#assign assetEntryLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetEntryLocalService")>
<#assign dlFileEntryLocalService = serviceLocator.findService("com.liferay.document.library.kernel.service.DLFileEntryLocalService")>
<#function getArticleDLEntryUrl xmlValue>
    <#local docUrl = "" />
    <#if xmlValue?has_content>
        <#local jsonObject = jsonFactoryUtil.createJSONObject(xmlValue) />
        <#local entryUuid = jsonObject.uuid />
        <#local entryGroupId = getterUtil.getLong(jsonObject.groupId) />
        <#if dlFileEntryLocalService.fetchDLFileEntryByUuidAndGroupId(entryUuid, entryGroupId)?has_content>
            <#local dlFileEntry = dlFileEntryLocalService.fetchDLFileEntryByUuidAndGroupId(entryUuid, entryGroupId) />
            <#local assetEntry = assetEntryLocalService.getEntry("com.liferay.document.library.kernel.model.DLFileEntry", dlFileEntry.fileEntryId) />
            <#local assetRenderer = assetEntry.assetRenderer />
            <#local docUrl = assetRenderer.getURLDownload(themeDisplay) />
        </#if>
    </#if>
    <#return docUrl />
</#function>
<div class="news-main-list">
    <#if entries?has_content>
        <#list entries as curEntry>
                <#assign assetRenderer = curEntry.getAssetRenderer() />
                <#assign viewUrl = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, assetRenderer, curEntry, true) />
                <#assign docXml=saxReaderUtil.read(curEntry.getAssetRenderer().getArticle().getContent()) />
                <#assign fieldValImage=docXml.valueOf( "//dynamic-element[@name='image']/dynamic-content/text()") />
                <#assign fieldValImageURL = getArticleDLEntryUrl(fieldValImage)>
                <div class="news-main-list__item">
                    <#if fieldValImage?has_content>
                        <a href="${viewUrl}" class="news-main-list__image" style="background-image: url('${fieldValImageURL}');">

                        </a>
                    <#else>
                        <div class="news-main-list__image"> </div>
                    </#if>
                    <strong><a href="${viewUrl}">${stringUtil.shorten(htmlUtil.stripHtml(curEntry.getTitle(locale)), 150)}</a></strong>
                    <span class="news-main-list__date">${curEntry.getPublishDate()?string("d MMMM")}</span>
                </div>
        </#list>
    </#if>
</div>

<script>
  // === SPA ===
  (function () {
      // utils
      const sendSPA = (params) => {
          if (window.gpnAnalytics) {
              window.gpnAnalytics.sendEvent(3, params);
          }
      };

      // api
      const getCurrentUser = async () => {
          const res = await fetch("/o/headless-admin-user/v1.0/my-user-account", {
              headers: {
                  "X-CSRF-Token": Liferay.authToken,
              },
          });
          return await res.json();
      };

      //Нажатие на новость
      const newsContainer = document.querySelector(".news-main-list");

      const handleNewClick = async (e) => {
          const newItem = e?.target.closest(".news-main-list__item");

          if (!newItem) return;

          try {
              const currentUser = await getCurrentUser();

              const customparams = [
                  {as_user_id: true, value: currentUser?.name || ""},
                  {name: 'user_id', type: 'STRING', value: currentUser?.name || ""},
                  {name: 'user_do', type: 'STRING', value: currentUser?.organizationBriefs[0]?.name || ""},
                  {name: 'new_location_main', type: 'STRING', value: "новости по теме"},
              ];

              sendSPA({
                  componentId: "news_pressed",
                  constaeventtype: "undefined",
                  component: "OTHER",
                  customparams,
              });
          } catch {}
      };

      newsContainer?.addEventListener("click", handleNewClick);
  })();
</script>
