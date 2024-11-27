<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:my="my:my" exclude-result-prefixes="my">
	<my:texts>
		<!-- English Labels -->
		<tableOfContents lang="en">TABLE OF CONTENTS</tableOfContents>
		<tocBoilerplate lang="en">Sections or subsections that are not applicable at the time of authorization are not listed.</tocBoilerplate>
		<productDetails lang="en">PRODUCT DETAILS</productDetails>
		<companyDetails lang="en">COMPANY DETAILS</companyDetails>
		<labeler lang="en">Market Authorization Holder</labeler>
		<registrant lang="en">Canadian Importer/Distributor</registrant>
		<partyAddress lang="en">Contact Address</partyAddress>
		<partyAdditional lang="en">Additional Contact Information</partyAdditional>
		<partyEmail lang="en">Email</partyEmail>
		<partyTel lang="en">Tel</partyTel>
		<partyWeb lang="en">Web</partyWeb>
		<product lang="en">Product</product>
		<productInfo lang="en">Product Information</productInfo>
		<brandName lang="en">Brand Name</brandName>
		<nonPropName lang="en">Non-Proprietary Name</nonPropName>
		<din lang="en">Drug Identification Number (DIN)</din>
		<adminRoute lang="en">Route of Administration</adminRoute>
		<dosageForm lang="en">Manufactured Dosage Form</dosageForm>
		<composition lang="en">Product Composition</composition>
		<activeIngredients lang="en">Active Ingredient</activeIngredients>
		<activeMoieties lang="en">Active Moiety</activeMoieties>
		<inactiveIngredients lang="en">Inactive Ingredients</inactiveIngredients>
		<ingredientName lang="en">Ingredient Name</ingredientName>
		<strength lang="en">Strength</strength>
		<basisOfStrength lang="en">Basis of Strength</basisOfStrength>
		<productType lang="en">Product Type</productType>
		<productCharacteristics lang="en">Product Characteristics</productCharacteristics>
		<color lang="en">Colour</color>
		<shape lang="en">Shape</shape>
		<score lang="en">Score</score>
		<size lang="en">Size</size>
		<imprint lang="en">Imprint</imprint>
		<flavor lang="en">Flavour</flavor>
		<combinationProduct lang="en">Combination Product Type</combinationProduct>
		<pharmaStandard lang="en">Pharmaceutical Standard</pharmaStandard>
		<schedule lang="en">Schedule</schedule>
		<therapeuticClass lang="en">Therapeutic Class</therapeuticClass>
		<packaging lang="en">Packaging Status</packaging>
		<itemCode lang="en">Package Identifier</itemCode>
		<packageDescription lang="en">Package Description</packageDescription>
		<packageRegStatus lang="en">Package Available</packageRegStatus>
		<productRegStatus lang="en">Product Regulatory Status</productRegStatus>
		<packageApprovalDate lang="en">Date of Authorization</packageApprovalDate>
		<productApprovalDate lang="en">Date of Initial Authorization</productApprovalDate>
		<cancellationDate lang="en">Date of Cancellation</cancellationDate>
		<marketingInfo lang="en">Product Status</marketingInfo>
		<marketingCategory lang="en">Regulatory Activity Type</marketingCategory>
		<applicationNumber lang="en">Control Number</applicationNumber>
		<partQuantity lang="en">Quantity of Parts</partQuantity>
		<partNumber lang="en">Part&#160;#</partNumber>
		<part lang="en">Part&#160;</part>
		<seeBelow lang="en">See below</seeBelow>
		<multiPartProduct lang="en">Multi-part product</multiPartProduct>
		<pkgQuantity lang="en">Package Quantity</pkgQuantity>
		<ttlProdQty lang="en">Total Product Quantity</ttlProdQty>
		<inConnective lang="en">&#160;in&#160;</inConnective>
		<andConnective lang="en">&#160;and&#160;</andConnective>
		<ofConnective lang="en">&#160;of&#160;</ofConnective>
		<toConnective lang="en">&#160;-&#160;</toConnective>
		<skipToMainContent lang="en">Skip to main content</skipToMainContent>

		<!-- French Labels -->
		<tableOfContents lang="fr">TABLE DES MATIÈRES</tableOfContents>
		<tocBoilerplate lang="fr">Les sections ou sous-sections qui ne sont pas pertinentes au moment de l’autorisation ne sont pas énumérées.</tocBoilerplate>
		<productDetails lang="fr">DÉTAILS SUR LE PRODUIT</productDetails>
		<companyDetails lang="fr">RENSEIGNEMENTS SUR L’ENTREPRISE</companyDetails>
		<labeler lang="fr">Détenteur de l’autorisation de mise sur le marché</labeler>
		<registrant lang="fr">Importateur/distributeur canadien</registrant>
		<partyAddress lang="fr">Adresse de la personne-ressource</partyAddress>
		<partyAdditional lang="fr">Autres coordonnées</partyAdditional>
		<partyEmail lang="fr">Couriel&#160;</partyEmail>
		<partyTel lang="fr">Tél.&#160;</partyTel>
		<partyWeb lang="fr">Site Web&#160;</partyWeb>
		<product lang="fr">Produit</product>
		<productInfo lang="fr">Renseignements sur le produit</productInfo>
		<brandName lang="fr">Nom de marque</brandName>
		<nonPropName lang="fr">Dénomination non exclusive</nonPropName>
		<din lang="fr">Numéro d’identification du médicament (DIN)</din>
		<adminRoute lang="fr">Voie d’administration</adminRoute>
		<dosageForm lang="fr">Forme posologique fabriquée</dosageForm>
		<composition lang="fr">Composition du produit</composition>
		<activeIngredients lang="fr">Principe actif</activeIngredients>
		<activeMoieties lang="fr">Fragment actif</activeMoieties>
		<inactiveIngredients lang="fr">Ingrédients inactifs</inactiveIngredients>
		<ingredientName lang="fr">Nom d’ingrédient</ingredientName>
		<strength lang="fr">Concentration</strength>
		<basisOfStrength lang="fr">Base de la concentration</basisOfStrength>
		<productType lang="fr">Type de produit</productType>
		<productCharacteristics lang="fr">Caractéristiques du produit</productCharacteristics>
		<color lang="fr">Couleur</color>
		<shape lang="fr">Forme</shape>
		<score lang="fr">Rainure</score>
		<size lang="fr">Taille</size>
		<imprint lang="fr">Empreinte</imprint>
		<flavor lang="fr">Saveur</flavor>
		<combinationProduct lang="fr">Type de produit combiné</combinationProduct>
		<pharmaStandard lang="fr">Norme pharmaceutique</pharmaStandard>
		<schedule lang="fr">Annexe</schedule>
		<therapeuticClass lang="fr">Classification thérapeutique</therapeuticClass>
		<packaging lang="fr">État de l’emballage</packaging>
		<itemCode lang="fr">Identificateur d’emballage</itemCode>
		<packageDescription lang="fr">Description de l’emballage</packageDescription>
		<packageRegStatus lang="fr">Emballage disponible</packageRegStatus>
		<productRegStatus lang="fr">État réglementaire du produit</productRegStatus>
		<packageApprovalDate lang="fr">Date de l’autorisation</packageApprovalDate>
		<productApprovalDate lang="fr">Date de l’autorisation initiale</productApprovalDate>
		<cancellationDate lang="fr">Date d’annulation</cancellationDate>
		<marketingInfo lang="fr">État du produit</marketingInfo>
		<marketingCategory lang="fr">Type d’activité de réglementation</marketingCategory>
		<applicationNumber lang="fr">Numéro de contrôle</applicationNumber>
		<partQuantity lang="fr">Nombre d’éléments</partQuantity>
		<partNumber lang="fr">No&#160;d’élément</partNumber>
		<part lang="fr">Élément&#160;</part>
		<seeBelow lang="fr">Voir ci-dessous</seeBelow>
		<multiPartProduct lang="fr">Produit en plusiers éléments</multiPartProduct>
		<pkgQuantity lang="fr">Nombre d’emballages</pkgQuantity>
		<ttlProdQty lang="fr">Quantité de produit totale</ttlProdQty>
		<inConnective lang="fr">&#160;dans&#160;</inConnective>
		<andConnective lang="fr">&#160;et&#160;</andConnective>
		<ofConnective lang="fr">&#160;de&#160;</ofConnective>
		<toConnective lang="fr">&#160;-&#160;</toConnective>
		<skipToMainContent lang="fr">Passer au contenu principal</skipToMainContent>
	</my:texts>
	<xsl:variable name="labels" select="document('')/*/my:texts"/>
		
	<!-- [pmh #93] Moved format-physical-quantity to spl_canada_i18n.xsl, since rendering is different for French and English values -->
	<xsl:decimal-format name="spaces" grouping-separator="&#160;"/>	
	<xsl:template match="@value" mode="format-physical-quantity">
		<xsl:choose>
			<xsl:when test="not(contains(., '.')) and $lang='en'"><xsl:value-of select="format-number(., '###,###,###,###')"/></xsl:when>
			<xsl:when test="not(contains(., '.')) and $lang='fr'"><xsl:value-of select="format-number(., '###&#160;###&#160;###&#160;###', 'spaces')"/></xsl:when>
			<xsl:when test="contains(., '.') and $lang='fr'"><xsl:value-of select="translate(., '.', ',')"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
		
	<!-- global templates like date and string cd formatting may be specialized for different regions -->
	<xsl:template name="string-lowercase">
		<!--** Convert the input text that is passed in as a parameter to lower case  -->
		<xsl:param name="text"/>
		<xsl:value-of select="translate($text,
			'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 
			'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')"/>
	</xsl:template>
	<xsl:template name="string-uppercase">
		<!--** Convert the input text that is passed in as a parameter to upper case  -->
		<xsl:param name="text"/>
		<xsl:value-of select="translate($text,
			'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ', 
			'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ')"/>
	</xsl:template>
	<xsl:template name="string-to-date">
		<xsl:param name="text"/>
		<xsl:param name="displayMonth">true</xsl:param>
		<xsl:param name="displayDay">true</xsl:param>
		<xsl:param name="displayYear">true</xsl:param>
		<xsl:param name="delimiter">-</xsl:param>
		<xsl:if test="string-length($text) > 7">
			<xsl:variable name="year" select="substring($text,1,4)"/>
			<xsl:variable name="month" select="substring($text,5,2)"/>
			<xsl:variable name="day" select="substring($text,7,2)"/>
			<xsl:if test="$displayYear = 'true'">
				<xsl:value-of select="$year"/>
				<xsl:value-of select="$delimiter"/>
			</xsl:if>
			<xsl:if test="$displayMonth = 'true'">
				<xsl:value-of select="$month"/>
				<xsl:value-of select="$delimiter"/>
			</xsl:if>
			<xsl:if test="$displayDay = 'true'">
				<xsl:value-of select="$day"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<!-- extra templating to convert 2020-01-01 to English or French formatted date -->
	<xsl:template name="string-to-internationalized-date">
		<xsl:param name="text"/>
		<xsl:variable name="year" select="substring($text,1,4)"/>
		<xsl:variable name="month" select="substring($text,6,2)"/>
		<xsl:variable name="day" select="substring($text,9,2)"/>
		<xsl:variable name="month-text" select="document('')/*/my:months[@lang=$lang]/my:mon[number($month)]/text()"/>
		<xsl:choose>
			<xsl:when test="$lang='en' and string-length($text)=10">
				<xsl:value-of select="$month-text"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="number($day)"/>,<xsl:text> </xsl:text>
				<xsl:value-of select="$year"/>			
			</xsl:when>
			<xsl:when test="$lang='fr' and string-length($text)=10">
				<xsl:value-of select="number($day)"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$month-text"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$year"/>			
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>			
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
	
	<!-- Data islands for French and English months - these could live in spl_canada_i18n.xsl -->
	<my:months lang="en">
		<my:mon>January</my:mon>
		<my:mon>February</my:mon>
		<my:mon>March</my:mon>
		<my:mon>April</my:mon>
		<my:mon>May</my:mon>
		<my:mon>June</my:mon>
		<my:mon>July</my:mon>
		<my:mon>August</my:mon>
		<my:mon>September</my:mon>
		<my:mon>October</my:mon>
		<my:mon>November</my:mon>
		<my:mon>December</my:mon>
	</my:months>
	<my:months lang="fr">
		<my:mon>janvier</my:mon>
		<my:mon>février</my:mon>
		<my:mon>mars</my:mon>
		<my:mon>avril</my:mon>
		<my:mon>mai</my:mon>
		<my:mon>juin</my:mon>
		<my:mon>juillet</my:mon>
		<my:mon>août</my:mon>
		<my:mon>septembre</my:mon>
		<my:mon>octobre</my:mon>
		<my:mon>novembre</my:mon>
		<my:mon>decembre</my:mon>
	</my:months>
		
</xsl:transform>
