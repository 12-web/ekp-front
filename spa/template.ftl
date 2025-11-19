 <#setting locale="ru_RU">
 <#assign DDMStructureLocalService = serviceLocator.findService("com.liferay.dynamic.data.mapping.service.DDMStructureLocalService")>
 <#assign structureName = DDMStructureLocalService.getStructure(themeDisplay.getCompanyGroupId(), article.getClassNameId(), article.getAssetRenderer().getArticle().getDDMStructureKey()).getName(locale)> <#-- Новости компании | Объявление | Новости -->


<#assign articleTitle = htmlUtil.stripHtml(article.getTitle(locale))> <#-- Заголовок новости -->
