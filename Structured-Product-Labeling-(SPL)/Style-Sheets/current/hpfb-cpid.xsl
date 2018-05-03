<?xml version="1.0" encoding="us-ascii"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v3="urn:hl7-org:v3" exclude-result-prefixes="v3 xsl">
	<xsl:import href="hpfb-cpid-core.xsl"/>
	<!-- "/.." means the value come from parent or caller parameter -->
	<xsl:param name="oids-base-url" select="'https://raw.githubusercontent.com/HealthCanada/HPFB/master/Controlled-Vocabularies/Content/'" />
	<!-- Where to find JavaScript and CSS resources -->
	<xsl:param name="resourcesdir" select="'https://rawgit.com/IanYangCa/HPFB/master/Structured-Product-Labeling-(SPL)/Style-Sheets/dev/'" />
	<xsl:param name="css" select="concat($resourcesdir, 'hpfb-cpid.css')" />
	<!-- is there any reason we render HTML 1.0?  -->
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:strip-space elements="*"/>
</xsl:transform>
