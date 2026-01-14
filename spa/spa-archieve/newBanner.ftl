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
<#if entries?has_content>
    <div class="news-main-slider">
        <#list entries as curEntry>
            <#assign assetRenderer = curEntry.getAssetRenderer() />
            <#assign viewUrl = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, assetRenderer, curEntry, true) />
            <#assign docXml=saxReaderUtil.read(curEntry.getAssetRenderer().getArticle().getContent()) />
            <#assign fieldValImage=docXml.valueOf( "//dynamic-element[@name='image']/dynamic-content/text()") />
            <#assign fieldValImageURL = getArticleDLEntryUrl(fieldValImage)>
            <div class="news-main-slider__item" <#if fieldValImage?has_content> style="background-image: url(${fieldValImageURL});" </#if>>
                <h3><a href="${viewUrl}">${stringUtil.shorten(htmlUtil.stripHtml(curEntry.getTitle(locale)), 140)}</a></h3>
                <div class="news-main-slider__details">
                    <span class="news-main-slider__date">${curEntry.getPublishDate()?string("d MMMM, HH:mm")}</span>
                    <span class="news-main-slider__viewcount">${curEntry.getViewCount()}</span>
                    <#if (enableRatings == "true")>
                        <@liferay_ui["ratings"]
                            className=curEntry.getClassName()
                            classPK=curEntry.getClassPK()
                            type="like"
                        />
                    </#if>
                </div>
            </div>
        </#list>
    </div>
    <div class="news-main-slider-pager">
        <#list entries as curEntry>
            <div class="news-main-slider-step"><a data-slide-index="${curEntry?index}" href="">${stringUtil.shorten(htmlUtil.stripHtml(curEntry.getTitle(locale)), 110)}</a></div>
        </#list>
    </div>
</#if>

<script type="text/javascript">
    var sliderMainSlider = $('.news-main-slider');
    if (sliderMainSlider.length) {
        sliderMainSlider.bxSlider({
            auto: true,
            pagerCustom: '.news-main-slider-pager',
            controls:false,
            touchEnabled: false,
            speed:1000,
            pause:5000,
            onSliderLoad: function() {
                setTimeout(function() {
                    $('.news-main-slider-pager').addClass('show-progress');
                }, 1000);
            },
            onSlideBefore: function() {
                setTimeout(function() {
                    $('.news-main-slider-pager').removeClass('show-progress');
                }, 0);
            },
            onSlideAfter: function() {
                setTimeout(function(){
                    $('.news-main-slider-pager').addClass('show-progress');
                    sliderMainSlider.stopAuto();
                    sliderMainSlider.startAuto();
                }, 50);
            }
        });
    }

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

      //Нажатие на баннер
      const newsBanner = document.querySelector(".news-main-slider");

      const handleNewsBannerClick = async (e) => {
          try {
              const currentUser = await getCurrentUser();

              const customparams = [
                  {as_user_id: true, value: currentUser?.name || ""},
                  {name: 'user_id', type: 'STRING', value: currentUser?.name || ""},
                  {name: 'user_do', type: 'STRING', value: currentUser?.organizationBriefs[0]?.name || ""},
                  {name: 'new_location_main', type: 'STRING', value: "большой баннер новости"},
              ];

              sendSPA({
                  componentId: "news_pressed",
                  constaeventtype: "undefined",
                  component: "OTHER",
                  customparams,
              });
          } catch {}
      };

      newsBanner?.addEventListener("click", handleNewsBannerClick);
  })();
</script>
