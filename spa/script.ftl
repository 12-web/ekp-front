<#assign journalArticleId = .vars['reserved-article-id'].data/>
<#assign journalArticleLocalService = serviceLocator.findService("com.liferay.journal.service.JournalArticleLocalService")/>
<#assign assetEntryLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetEntryLocalService" )/>
<#assign article = journalArticleLocalService.getArticle(groupId ,journalArticleId)/>
<#assign AssetTagLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetTagLocalService") />
<#assign assetVocabularyLocalServiceUtil = staticUtil["com.liferay.asset.kernel.service.AssetVocabularyLocalServiceUtil"]>
<#assign FastDateFormatFactoryUtil = staticUtil["com.liferay.portal.kernel.util.FastDateFormatFactoryUtil"]>
<#assign TimeZone = staticUtil["java.util.TimeZone"]>
<#assign userTimeZone = TimeZone.getTimeZone("Europe/Moscow")>
<#assign formatterTimeOnly = FastDateFormatFactoryUtil.getSimpleDateFormat("HH:mm", originalLocale, userTimeZone)>
<#assign formatterDateTime = FastDateFormatFactoryUtil.getSimpleDateFormat("d MMMM, HH:mm", originalLocale, userTimeZone)>
<#assign displaydate = .vars['reserved-article-display-date'].data>
<#assign originalLocale = .locale>
<#setting locale = 'ru_RU'>
<#assign displaydateInfo = displaydate?date("EEE, d MMM yyyy HH:mm")>
<#assign publishDate = article.getDisplayDate()?long>
<#assign now = .now?long>
<#assign oneDayInMillis = 24 * 60 * 60 * 1000>

<#assign displayDate = article.getDisplayDate()>
<#assign now = .now?long>
<#assign mscOffset = userTimeZone.getOffset(now)>
<#assign mscwTime = now + mscOffset>
<#assign publishDateMoscow = publishDate + mscOffset>
<#assign startOfToday = mscwTime - (mscwTime % oneDayInMillis)>
<#assign startOfPublishDay = publishDateMoscow - (publishDateMoscow % oneDayInMillis)>
<#assign daysDiff = ((startOfToday - startOfPublishDay) / oneDayInMillis)?round>

<#assign tags = AssetTagLocalService.getTags("com.liferay.journal.model.JournalArticle", article.getResourcePrimKey()) />
<#assign assetCategoryLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryLocalService") />
<#assign categories = assetCategoryLocalService.getCategories("com.liferay.journal.model.JournalArticle", article.getResourcePrimKey()) />
<#assign currentArticleAssetEntry = assetEntryLocalService.getEntry("com.liferay.journal.model.JournalArticle", article.getResourcePrimKey())/>
<#assign nameDocument = 2>
<#assign formatDocument = 5>
<#assign preferences = renderRequest.getPreferences() >
<#assign UserLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.UserLocalService")>
<#assign liferay_ui = PortletJspTagLibs["/META-INF/liferay-ui.tld"] />
<#assign metadataFields = preferences.getValue('metadataFields', '') />
<#assign enableRatings = preferences.getValue('enableRatings', '') />

<style>
	.asset-full-content > .col-md-12 .taglib-discussion {
		display: none
	}

	.asset-details {
		display: none;
	}
</style>

<div class="news-template-wrapper">
	<div class="news-template-display__date">
		<div class="news-template-details__publish-info">
            <div class="news-template-details__date">

				<#if daysDiff == 0>
					Сегодня, ${formatterTimeOnly.format(displayDate)}
				<#elseif daysDiff == 1>
					Вчера, ${formatterTimeOnly.format(displayDate)}
				<#else>
					${formatterDateTime.format(displayDate)}
				</#if>

                <#if metadataFields?contains("view-count")>
                    <div class="news-template-assets_times">
                    <div class="news-template-assets_times__view"></div>
                        ${currentArticleAssetEntry.getViewCount()}
                    </div>
                </#if>
            </div>
		</div>
	</div>
	<#if categories?has_content>
		<#list categories as category>
			<input class="news-template-wrapper-category-id" type="hidden" value="${category.getCategoryId()}">
		</#list>
	</#if>
	<div class="news-template-text">${text.getData()}</div>
	<#if quote?has_content>
		<#if quote.getSiblings()?has_content && validator.isNotNull(quote.getData())>
			<div class="news-template-quote">
				<div class="quotes-slider">
					<#list quote.getSiblings() as cur_quote>
						<div class="news-template-quote-item">
							<p class="news-template-quote-text">
								${cur_quote.getData()}
							</p>
							<#if cur_quote.autorC.getData()?has_content>
								<#assign user = UserLocalService.fetchUser(cur_quote.autorC.getData()?number) />
								<div class="news-template-quote-container">
									<div>
										<@liferay_ui["user-portrait"]
											userId=cur_quote.autorC.getData()?number
										/>
									</div>
									<div class="news-template-quote-user">
										<div class="news-template-quote-name">
											${htmlUtil.escape(user.getFullName())}
										</div>
										<div class="news-template-quote-position">${htmlUtil.escape(user.getJobTitle())}</div>
									</div>
								</div>
							</#if>
						</div>
					</#list>
				</div>
			</div>
		</#if>
	</#if>
	<#if information?has_content && validator.isNotNull(information.getData())>
		<div class="news-template-references">
			<div class="news-template-reference-article">Справка</div>
			${information.getData()}
		</div>
	</#if>
	<#if attachment?has_content && validator.isNotNull(attachment.getData())>
		<div class="news-template-attachment">
			<h2>Вложение</h2>
			<#if attachment.getSiblings()?has_content>
				<div class="news-template-insert">
					<#list attachment.getSiblings() as cur_attachment>
						<a href="${cur_attachment.getData() + '&download=true'}" class="news-template-idea__attachment">
							<#assign counter = 0 >
							<#list cur_attachment.getData()?split("/") as x>
								<#if counter == nameDocument>
									<#assign groupId = x?number >
								</#if>
								<#if counter == formatDocument>
									<#assign uuId = x >
								</#if>
								<#assign counter = counter + 1 >
							</#list>
							<#assign dlFileEntryService = serviceLocator.findService('com.liferay.document.library.kernel.service.DLFileEntryService')>
							<#assign file=dlFileEntryService.getFileEntryByUuidAndGroupId(uuId?keep_before_last("?"),groupId)>
							<div class="doc"></div>
							${file.getTitle()}
						</a>
					</#list>
				</div>
			</#if>
		</div>
	</#if>
	<#if tags?has_content>
		<div class="news-template-tags">
			<div class="news-template-tags-article">
				Теги
			</div>
			<div class="news-template-tags-items">
				<#list tags as tag>
					<div class="news-template-tags-item">
						${tag.getName()}
					</div>
				</#list>
			</div>
		</div>
	</#if>
	<#if enableRatings == 'true'>
		<div class="news-template-assets">
			<div class="news-template-assets_likes">
				Мне нравится
				<@liferay_ui["ratings"]
					className = "com.liferay.journal.model.JournalArticle"
					classPK = article.getResourcePrimKey()
					type="like"
				/>
			</div>
		</div>
	</#if>
	<#if preferences.getValue('enableComments','') == 'true'>
		<div class="news-template-assets-comment">
			<div class="news-template-assets-article">
				<div class="news-template-assets-article__img">
				</div>
				<div class="news-template-assets-article__text">
					Комментарии
				</div>
				<div class="news-template-assets-article__count">
				</div>
			</div>
			<div class="news-template-assets_comments">
				<@liferay_comment["discussion"]
					className="com.liferay.journal.model.JournalArticle"
					classPK=article.getResourcePrimKey()
				/>
			</div>
		</div>
	</#if>
</div>
<div class="news-template-dynamics" style="display: none;">
	<#assign categoryID = "">
	<#assign assetCategoryLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryLocalService") />
	<#assign categories = assetCategoryLocalService.getCategories("com.liferay.journal.model.JournalArticle", article.getResourcePrimKey()) />
	<#if categories?has_content>
		<#list categories as category>
			<#assign categoryVocab = category.vocabularyId />
			<#assign vocabulary=assetVocabularyLocalServiceUtil.getAssetVocabulary(categoryVocab)>
			<#assign vocabularyName = vocabulary.getName()>
			<#if vocabularyName = "тематика новостей">
				<span>${category.name}</span>
				<#assign categoryID = category.categoryId>
			</#if>
		</#list>
	</#if>
</div>

<#if categoryID?has_content>
	<div class="news-template-dynamics-info">
		<#assign preferences = freeMarkerPortletPreferences.getPreferences({"portletSetupPortletDecoratorId": "barebone", "displayStyle" : "ddmTemplate_793033",  "queryContains0":"true", "queryAndOperator0":"true", "queryName0":"assetCategories",  "queryValues0": categoryID?string,  "delta": "50", "metadataFields": metadataFields, "enableRatings": enableRatings}) />
		<@liferay_portlet["runtime"] instanceId="dynamic-news-template-${categoryID}_v2" defaultPreferences="${preferences}"  portletName="com_liferay_asset_publisher_web_portlet_AssetPublisherPortlet"/>
	</div>
</#if>

<script>
	const changeNewsDisplayEvent = new CustomEvent('changeNewsDisplay');
	document.dispatchEvent(changeNewsDisplayEvent);

	const initMediagalleryEvent = new CustomEvent('initMediagallery');
	document.dispatchEvent(initMediagalleryEvent);
</script>
