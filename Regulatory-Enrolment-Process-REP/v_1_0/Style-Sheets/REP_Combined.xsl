<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
	<xsl:template match="/">

		<html>
		<style type="text/css">
			html {
            height: auto !important;
            }
            body{
            height: auto !important;
            }
            h1{
            font-family: Helvetica,Arial,sans-serif;
            color: black;
            }
            h2
            {
            font-family: Helvetica,Arial,sans-serif;
            font-size: 24;
            font-weight: 600;
            color: #fff;
            }
            h3
            {
            font-family: Helvetica,Arial,sans-serif;
            display:block;
            font-weight:bold;
            color:black;
            }
            h4
            {
            font-family: Helvetica,Arial,sans-serif;
            display:block;
            font-weight:bold;
            color:black;
            }
            .labels
            {
            display: block;
            color:black;
            background-color: inherit;
            font-family: Helvetica, Arial, sans-serif;
            font-weight: bold;
            }
            .company_enrol
            {
            display:block;
            color:black;
            background-color: white;
            border: 1px solid;
            font-family: Helvetica,Arial,sans-serif;
            height: auto;
            word-wrap: break-word;
            }
			.dossier_enrol
            {
            display:block;
            color:black;
            background-color: white;
            border: 1px solid;
            font-family: Helvetica,Arial,sans-serif;
            height: auto;
            word-wrap: break-word;
            }
			.activity_enrol
            {
            display:block;
            color:black;
            background-color: white;
            border: 1px solid;
            font-family: Helvetica,Arial,sans-serif;
            height: auto;
            word-wrap: break-word;
            }
			.transaction_enrol
            {
            display:block;
            color:black;
            background-color: white;
            border: 1px solid;
            font-family: Helvetica,Arial,sans-serif;
            height: auto;
            word-wrap: break-word;
            }
            .row{
            overflow:hidden;
            text-overflow:ellipsis;
            }
            .panel {
            margin-bottom: 0.65%;
            background-color: white;
            border: 1px solid transparent;
            border-radius: 4px;
            -webkit-box-shadow: 0 1px 1px rgba(0,0,0,.05);
            box-shadow: 0 1px 1px rgba(0,0,0,.05);
            height: auto;
            display: block;
            float: left;
            width: 100%;
            }
            .panel-primary {
            border-color: #0C5A9F;
            }
            .panel-primary {
            border-color: #2572b4;
            background-color: white;
            }
            .panel-heading {
            padding: 0.50% 0.75%;
            border-bottom: 1px solid transparent;
            border-top-right-radius: 3px;
            border-top-left-radius: 3px;
            background-color: #0C5A9F;
            border-color: #faeacc;
            }
            .panel-title {
            margin-top: 0;
            margin-bottom: 0;
            font-size: 20;
            color: white;
            }
            .panel-body {
            padding: 0.75%;
            display: block;
            }
            .panel-warning {
            border-color: #faeacc;
            }
            .panel-warning .panel-heading {
            color: #634615;
            background-color: #fcf8e3;
            border-color: #faeacc;
            }
            .panel-warning .panel-title {
            color: #634615;
            background-color: #fcf8e3;
            border-color: #faeacc;
            }
            .panel-warning .panel-body {
            padding: 0.75%;
            height: auto;
            display: block;
            }
            .well-sm {
            border-radius: 0.15%;
            }
            .well {
            float: left;
            width: 98.8%;
            padding: 0.50%;
            margin-bottom: 0.25%;
            background-color: #f5f5f5;
            border: 1px solid #e3e3e3;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
            }
            .col-sm-005 {
            width: 5.0%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-008 {
            width: 8.0%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-012 {
            width: 12.3%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-016 {
            width: 16.10%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-019 {
            width: 19.42%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-021 {
            width: 21.65%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-022 {
            width: 22.29%;
            float: left;
           padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-023 {
            width: 23.70%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-024 {
            width: 24.43%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-027 {
            width: 27.20%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-032 {
            width: 32.77%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-035 {
            width: 35.60%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-036 {
            width: 36.68%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-049 {
            width: 49.4%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-074 {
            width: 74.50%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
			.col-sm-097 {
            width: 97.4%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
            .col-sm-099 {
            width: 99.4%;
            float: left;
            padding: 0.25%;
            margin-bottom: 0.125%;
            }
		</style>
			<body>
				<xsl:if test="count(COMPANY_ENROL) &gt; 0"> <xsl:apply-templates select="COMPANY_ENROL"></xsl:apply-templates> </xsl:if>
				<xsl:if test="count(DOSSIER_ENROL) &gt; 0"> <xsl:apply-templates select="DOSSIER_ENROL"></xsl:apply-templates> </xsl:if>
				<xsl:if test="count(ACTIVITY_ENROL) &gt; 0"> <xsl:apply-templates select="ACTIVITY_ENROL"></xsl:apply-templates> </xsl:if>
				<xsl:if test="count(TRANSACTION_ENROL) &gt; 0"> <xsl:apply-templates select="TRANSACTION_ENROL"></xsl:apply-templates> </xsl:if>
			</body>
		</html>
	</xsl:template>

	<!-- Company Enrolment -->
	<xsl:template match="COMPANY_ENROL">
		<h1>Regulatory Enrolment Process</h1>
		<section>
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h2 class="panel-title">Company Enrolment Information</h2>
				</div>

				<div class="panel-body">
					<div class="well well-sm" >
						<div class="row">
							<div class="col-sm-099">
								<span class="labels"> Company ID </span>
								<span class="company_enrol"> <xsl:apply-templates select="company_id" /> </span>
							</div>
						</div>
					</div>

					<br />

					<h3> Address Records </h3>

					<xsl:for-each select="address_record">
						<div class="panel panel-warning">
							<header class="panel-warning panel-heading" >
								<h3 class="panel-warning panel-title" >
									Address <xsl:value-of select="position()"/>
									<xsl:if test="(manufacturer = 'Y') or (mailing = 'Y') or (billing = 'Y') or (importer = 'Y')">
										(<xsl:if test="manufacturer = 'Y'">Manufacturer/Sponsor</xsl:if>
										<xsl:if test="(manufacturer = 'Y') and ((mailing = 'Y') or (billing = 'Y') or (importer = 'Y'))">, </xsl:if>
										<xsl:if test="mailing = 'Y'">Mailing</xsl:if>
										<xsl:if test="(mailing = 'Y') and ((billing = 'Y') or (importer = 'Y'))">, </xsl:if>
										<xsl:if test="billing = 'Y'">Billing</xsl:if>
										<xsl:if test="(billing = 'Y') and (importer = 'Y')">, </xsl:if>
										<xsl:if test="importer = 'Y'">Canadian Importer</xsl:if>)
									</xsl:if>
								</h3>
							</header>

							<div>
							<div class="panel-warning panel-body">
								<div class="col-sm-099" >
									<h4> Company Information </h4>
									<div class="well well-sm" >
										<div class="row">
											<div class="col-sm-099">
												<span class="labels"> Company Name [Full Legal Name] </span>
												<span class="company_enrol"> <xsl:apply-templates select="company_name" /> </span>
											</div>
										</div>
									</div>
								</div>

								<div class="col-sm-099">
									<h4> Address Information </h4>
									<div class="well well-sm">
										<div class="row">
											<div class="col-sm-099">
												<span class="labels"> Street / Suite / P.O. Box </span>
												<span class="company_enrol"> <xsl:apply-templates select="company_address_details/street_address" /> </span>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-024">
												<span class="labels"> City / Town </span>
												<span class="company_enrol"> <xsl:apply-templates select="company_address_details/city" /> </span>
											</div>
											<div class="col-sm-024">
												<span class="labels"> Province </span>
												<span class="company_enrol"> <xsl:choose><xsl:when test="(company_address_details/country = 'CAN') or (company_address_details/country = 'USA')"><xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="company_address_details/province_lov"/> </xsl:call-template></xsl:when><xsl:otherwise><xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="company_address_details/province_text"/> </xsl:call-template></xsl:otherwise></xsl:choose> </span>
											</div>
											<div class="col-sm-024">
												<span class="labels"> Country </span>
												<span class="company_enrol"> <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="company_address_details/country"/> </xsl:call-template> </span>
											</div>
											<div class="col-sm-024">
												<span class="labels"> Postal / ZIP Code </span>
												<span class="company_enrol"> <xsl:apply-templates select="company_address_details/postal_code" /> </span>
											</div>
										</div>
									</div>
								</div>

							</div>
							</div>
						</div>
					</xsl:for-each>

					<h3> Contact Records </h3>

					<xsl:for-each select="contact_record">
						<div class="panel panel-warning">
							<header class="panel-warning panel-heading" >
								<h3 class="panel-warning panel-title" >
									Contact <xsl:value-of select="position()"/>
									<xsl:if test="(manufacturer = 'Y') or (mailing = 'Y') or (billing = 'Y') or (rep_primary = 'Y') or (rep_secondary = 'Y')">
										(<xsl:if test="manufacturer = 'Y'">Manufacturer/Sponsor</xsl:if>
										<xsl:if test="(manufacturer = 'Y') and ((mailing = 'Y') or (billing = 'Y') or (rep_primary = 'Y') or (rep_secondary = 'Y'))">, </xsl:if>
										<xsl:if test="mailing = 'Y'">Mailing</xsl:if>
										<xsl:if test="(mailing = 'Y') and ((billing = 'Y') or (rep_primary = 'Y') or (rep_secondary = 'Y'))">, </xsl:if>
										<xsl:if test="billing = 'Y'">Billing</xsl:if>
										<xsl:if test="(billing = 'Y') and ((rep_primary = 'Y') or (rep_secondary = 'Y'))">, </xsl:if>
										<xsl:if test="rep_primary = 'Y'">REP Primary</xsl:if>
										<xsl:if test="(rep_primary = 'Y') and (rep_secondary = 'Y')">, </xsl:if>
										<xsl:if test="rep_secondary = 'Y'">REP Secondary</xsl:if>)
									</xsl:if>
								</h3>
							</header>

							<div class="panel-warning panel-body">
								<div class="col-sm-099">
									<h4> Company Representative Information </h4>
									<div class="well well-sm" >
										<div class="row">
											<div class="col-sm-005">
												<span class="labels"> Salutation </span>
												<span class="company_enrol"> <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="company_contact_details/salutation"/> </xsl:call-template> </span>
											</div>
											<div class="col-sm-021">
												<span class="labels"> Given Name </span>
												<span class="company_enrol"> <xsl:apply-templates select="company_contact_details/given_name" /> </span>
											</div>
											<div class="col-sm-005">
												<span class="labels"> Initials </span>
												<span class="company_enrol"> <xsl:apply-templates select="company_contact_details/initials" /> </span>
											</div>
											<div class="col-sm-021">
												<span class="labels"> Surname </span>
												<span class="company_enrol"> <xsl:apply-templates select="company_contact_details/surname" /> </span>
											</div>
											<div class="col-sm-021">
												<span class="labels"> Job Title </span>
												<span class="company_enrol"> <xsl:apply-templates select="company_contact_details/job_title" /> </span>
											</div>
											<div class="col-sm-021">
												<span class="labels"> Language Correspondence </span>
												<span class="company_enrol"> <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="company_contact_details/language_correspondance"/> </xsl:call-template> </span>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-027">
												<span class="labels"> Phone Number </span>
												<span class="company_enrol"> <xsl:apply-templates select="company_contact_details/phone_num" /> </span>
											</div>
											<div class="col-sm-016">
												<span class="labels"> Phone Extension </span>
												<span class="company_enrol"> <xsl:apply-templates select="company_contact_details/phone_ext" /> </span>
											</div>
											<div class="col-sm-027">
												<span class="labels"> Fax Number </span>
												<span class="company_enrol"> <xsl:apply-templates select="company_contact_details/fax_num" /> </span>
											</div>
											<div class="col-sm-027">
												<span class="labels"> Email </span>
												<span class="company_enrol"> <xsl:apply-templates select="company_contact_details/email" /> </span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</xsl:for-each>
				</div>
			</div>
		</section>
	</xsl:template>


	<!-- Dossier Enrolment -->
    <xsl:template match="DOSSIER_ENROL">
        <h1>Regulatory Enrolment Process</h1>
        <section>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h2 class="panel-title">Dossier Information</h2>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-099">
                            <span class="labels"> Company ID </span>
                            <span class="dossier_enrol">
                                <xsl:apply-templates select="company_id" />
                            </span>
                        </div>
                    </div>
					<div class="row">
                        <div class="col-sm-099">
                            <span class="labels"> Dossier Type </span>
                            <span class="dossier_enrol">
                                <xsl:apply-templates select="dossier_type" />
                            </span>
                        </div>
                    </div>
					<div class="row">
                        <div class="col-sm-099">
                            <span class="labels">
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test="third_party_signed = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
                                </xsl:element>
                                The submission will be signed or filed by a third party on behalf of the manufacturer or sponsor
                            </span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-099">
                            <span class="labels" > Brand or Proprietary or Product Name (should be the same as the brand name on the product label)* </span>
                            <span class="dossier_enrol">
                                <xsl:apply-templates select="product_name" />
                            </span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-099">
                            <span class="labels" > Proper, Common or Non-Proprietary Name </span>
                            <span class="dossier_enrol">
                                <xsl:apply-templates select="common_name" />
                            </span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-099">
                            <span class="labels" > Related Information [If applicable] </span>
                            <span class="dossier_enrol">
                                <xsl:apply-templates select="related_dossier_id" />
                            </span>
                        </div>
                    </div>
                    <div class="well well-sm">
                        <h3 style="margin-left: 0.25%; text-decoration: underline;"> Therapeutic Classification(s) </h3>
                        <xsl:for-each select="therapeutic_class_list/therapeutic_class">
                            <div class="row">
                                <div class="col-sm-099" >
                                    <span class="labels">
                                        Therapeutic Classification
                                        <xsl:value-of select="position()"/>
                                    </span>
                                    <span class="dossier_enrol">
                                        <xsl:apply-templates select="." />
                                    </span>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                    <div class="panel panel-warning">
                        <header class="panel-warning panel-heading" >
                            <h3 class="panel-warning panel-title" >
                                Canadian Reference Product
                            </h3>
                        </header>
                        <div class="panel-warning panel-body">
                            <div class="col-sm-099">
                                <div class="well well-sm" >
                                    <div class="row">
                                        <div class="col-sm-049">
                                            <span class="labels"> Brand Name: </span>
                                            <span class="dossier_enrol">
                                                <xsl:apply-templates select="brand_name" />
                                            </span>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-099">
                                            <span class="labels"> Company Name </span>
                                            <span class="dossier_enrol">
                                                <xsl:apply-templates select="company_name" />
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </section>
    </xsl:template>


	<!-- Activity Enrolment -->
	<xsl:template match="ACTIVITY_ENROL">
		<h1>Regulatory Enrolment Process</h1>
		<section>
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h2 class="panel-title">Regulatory Activity Information</h2>
				</div>

				<div class="panel-body">
					<div class="well well-sm" >
						<div class="row">
							<div class="col-sm-099">
								<span class="labels"> Control Number </span>
								<span class="activity_enrol"> <xsl:apply-templates select="dsts_control_number" /> </span>
							</div>
						</div>
					</div>
					<br />
					<br />
					<br />
					<br />

					<div class="row">
						<div class="col-sm-049">
							<span class="labels"> Company ID </span>
							<span class="activity_enrol"> <xsl:apply-templates select="company_id" /> </span>
						</div>
						<div class="col-sm-049">
							<span class="labels"> Dossier ID </span>
							<span class="activity_enrol"> <xsl:apply-templates select="dossier_id_concat" /> </span>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-049">
							<span class="labels"> Regulatory Activity Lead </span>
							<span class="activity_enrol"> <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="reg_activity_lead"/> </xsl:call-template> </span>
						</div>
						<div class="col-sm-049">
							<span class="labels"> Regulatory Activity Type </span>
							<span class="activity_enrol"> <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="reg_activity_type"/> </xsl:call-template> </span>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-049">
							<span class="labels"> Fee Class </span>
							<span class="activity_enrol"> <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="fee_class"/> </xsl:call-template> </span>
						</div>
						<div class="col-sm-049">
							<span class="labels" style="visibility: hidden;"> . </span>
							<span class="labels">
								<xsl:element name="input">
									<xsl:attribute name="type">checkbox</xsl:attribute>
									<xsl:if test="not_lasa = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
									<xsl:attribute name="disabled">disabled</xsl:attribute>
								</xsl:element>
								I confirm that this administrative submission type is NOT a LASA submission.
							</span>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-099">
							<span class="labels"> Reason for filing this Regulatory Activity: </span>
							<span class="activity_enrol"> <xsl:call-template name="String_To_Paragraph"> <xsl:with-param name="input" select="reason_filing"/> </xsl:call-template>	</span>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-099">
							<span class="labels"> Will the submission be signed or filed by a third party on behalf of the manufacturer or sponsor? </span>
							<span class="activity_enrol"> <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="is_third_party"/> </xsl:call-template> </span>
						</div>
					</div>

					<br />

					<xsl:for-each select="related_activity">
						<div class="panel panel-warning">
							<header class="panel-warning panel-heading" >
								<h3 class="panel-warning panel-title" > Related Regulatory Activity <xsl:value-of select="position()"/> </h3>
							</header>

							<div class="panel-warning panel-body">
								<div class="col-sm-099">
									<div class="well well-sm" >
										<div class="row">
											<div class="col-sm-099">
												<span class="labels"> Regulatory Activity Type: </span>
												<span class="activity_enrol"> <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="reg_activity_type"/> </xsl:call-template> </span>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-032">
												<span class="labels"> Date Cleared: </span>
												<span class="activity_enrol"> <xsl:apply-templates select="date_cleared" /> </span>
											</div>
											<div class="col-sm-032">
												<span class="labels"> Control No. </span>
												<span class="activity_enrol"> <xsl:apply-templates select="control_number" /> </span>
											</div>
											<div class="col-sm-032">
												<span class="labels"> Dossier ID (Previously File No.) </span>
												<span class="activity_enrol"> <xsl:apply-templates select="dossier_id" /> </span>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-099">
												<span class="labels"> Manufacturer / Sponsor Name [Full Legal Name - No Abbreviations] </span>
												<span class="activity_enrol"> <xsl:apply-templates select="manufacturer_name" /> </span>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-099">
												<span class="labels"> Reason for Submissions </span>
												<span class="activity_enrol"> <xsl:call-template name="String_To_Paragraph"> <xsl:with-param name="input" select="reason_filing"/> </xsl:call-template>	</span>
											</div>
										</div>
										<div class="row">
											<xsl:for-each select="assoc_dins/din_number">
												<div class="col-sm-024">
													<span class="labels"> Associated DIN </span>
													<span class="activity_enrol"> <xsl:value-of select="."/> </span>
												</div>
											</xsl:for-each>
										</div>
									</div>
								</div>
							</div>
						</div>
					</xsl:for-each>
				</div>
			</div>

			<xsl:if test="((reg_activity_type = 'DIN') or (reg_activity_type = 'SANDS') or (reg_activity_type = 'SNDS') or (reg_activity_type = 'NC'))">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h2 class="panel-title">Drug Product Formulation Information</h2>
					</div>

					<div class="panel-body">
						<xsl:if test="((reg_activity_type = 'DIN') or (reg_activity_type = 'SANDS') or (reg_activity_type = 'SNDS'))">
							<h3 style="margin-left: 0.25%; text-decoration: underline;"> Rationale for all SNDS, SANDS, or for biological drug DIN submissions </h3>
							<div class="well well-sm" >
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="rationale_types/new_roa = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											New route of administration, dosage form and/or strength
										</span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="rationale_types/new_claims = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											New claims/use, indications, recommended administration or dosage regime
										</span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="rationale_types/change_formulation = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											Change in formulation or method of manufacturing with clinical/bio data
										</span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="rationale_types/change_drug_substance = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											Change in drug substance/product (site, method, equipment, process control)
										</span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="rationale_types/replace_sterility = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											Replace sterility test with process parametric release
										</span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="rationale_types/confirmitory_studies = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											Confirmatory studies
										</span>
									</div>
								</div>
								<xsl:if test="rationale_types/other_rationale = 'Y'">
									<div class="row">
										<div class="col-sm-099">
											<span class="labels">
												<xsl:element name="input">
													<xsl:attribute name="type">checkbox</xsl:attribute>
													<xsl:if test="rationale_types/other_rationale = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
													<xsl:attribute name="disabled">disabled</xsl:attribute>
												</xsl:element>
												Other (please specify):
											</span>
										</div>
									</div>
								</xsl:if>
								<xsl:if test="not(rationale_types/other_rationale_details = '')">
									<div class="row">
										<div class="col-sm-099">
											<span class="labels"> Other Rationale Details: </span>
											<span class="activity_enrol"> <xsl:apply-templates select="rationale_types/other_rationale_details" /> </span>
										</div>
									</div>
								</xsl:if>
							</div>
						</xsl:if>

						<xsl:if test="(reg_activity_type = 'NC')">
							<h3 style="margin-left: 0.25%; text-decoration: underline;"> Type of Notifiable Change (NC) submission </h3>
							<div class="well well-sm" >
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="notifiable_change_types/text_label_change = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											Change in text of labelling
										</span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="notifiable_change_types/drug_substance_change = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											Change in drug substance (source, synthesis)
										</span>
									</div>
								</div>

								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="notifiable_change_types/formulation_change = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											Change in formulation
										</span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="notifiable_change_types/specification_change = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											Change in specifications (medicinal or non-medicinal ingredient, pharmaceutical form, analytical method)
										</span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="notifiable_change_types/expiry_storage_change = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											Change in expiry period/storage conditions
										</span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="notifiable_change_types/manufact_method_change = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											Change in manufacturing method
										</span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="notifiable_change_types/manufact_site_change = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											Change in manufacturing site
										</span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="notifiable_change_types/container_size_change = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											Change in container size for parenteral drug
										</span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="notifiable_change_types/packaging_spec_change = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											Change in packaging specifications for parenteral/inhalation drug
										</span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-099">
										<span class="labels">
											<xsl:element name="input">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:if test="notifiable_change_types/packaging_materials_change = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:element>
											Change in packaging material composition
										</span>
									</div>
								</div>
								<xsl:if test="notifiable_change_types/other_change = 'Y'">
									<div class="row">
										<div class="col-sm-099">
											<span class="labels">
												<xsl:element name="input">
													<xsl:attribute name="type">checkbox</xsl:attribute>
													<xsl:if test="notifiable_change_types/other_change = 'Y'"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
													<xsl:attribute name="disabled">disabled</xsl:attribute>
												</xsl:element>
												Other (please specify):
											</span>
										</div>
									</div>
								</xsl:if>
								<xsl:if test="not(notifiable_change_types/other_change_details = '')">
									<div class="row">
										<div class="col-sm-099">
											<span class="labels"> Other Rationale Details: </span>
											<span class="activity_enrol"> <xsl:apply-templates select="notifiable_change_types/other_change_details" /> </span>
										</div>
									</div>
								</xsl:if>
							</div>
						</xsl:if>
					</div>
				</div>
			</xsl:if>

			<br />

			<div class="panel panel-primary">
                <div class="panel-heading">
                    <h2 class="panel-title"> REP Contact Details </h2>
                </div>
                <div class="panel-body">
                    <xsl:for-each select="contact_record">
                        <div class="panel panel-warning">
                            <header class="panel-warning panel-heading" >
                                <h3 class="panel-warning panel-title" >
                                    <xsl:if test="rep_contact_role = 'PRIMARY'">Primary Contact</xsl:if>
									<xsl:if test="rep_contact_role = 'SECONDARY'">Secondary Contact</xsl:if>
                                </h3>
                            </header>
                            <div class="panel-warning panel-body">
                                <div class="col-sm-099">
                                    <div class="well well-sm" >
                                        <div class="row">
                                            <div class="col-sm-005">
                                                <span class="labels"> Salutation </span>
                                                <span class="activity_enrol">
                                                    <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="rep_contact_details/salutation"/> </xsl:call-template>
                                                </span>
                                            </div>
                                            <div class="col-sm-021">
                                                <span class="labels"> Given Name </span>
                                                <span class="activity_enrol">
                                                    <xsl:apply-templates select="rep_contact_details/given_name" />
                                                </span>
                                            </div>
                                            <div class="col-sm-005">
                                                <span class="labels"> Initials </span>
                                                <span class="activity_enrol">
                                                    <xsl:apply-templates select="rep_contact_details/initials" />
                                                </span>
                                            </div>
                                            <div class="col-sm-021">
                                                <span class="labels"> Surname </span>
                                                <span class="activity_enrol">
                                                    <xsl:apply-templates select="rep_contact_details/surname" />
                                                </span>
                                            </div>
                                            <div class="col-sm-021">
                                                <span class="labels"> Job Title </span>
                                                <span class="activity_enrol">
                                                    <xsl:apply-templates select="rep_contact_details/job_title" />
                                                </span>
                                            </div>
                                            <div class="col-sm-021">
                                                <span class="labels"> Language Correspondence </span>
                                                <span class="activity_enrol">
                                                    <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="rep_contact_details/language_correspondance"/> </xsl:call-template>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-027">
                                                <span class="labels"> Phone Number </span>
                                                <span class="activity_enrol">
                                                    <xsl:apply-templates select="rep_contact_details/phone_num" />
                                                </span>
                                            </div>
                                            <div class="col-sm-016">
                                                <span class="labels"> Phone Extension </span>
                                                <span class="activity_enrol">
                                                    <xsl:apply-templates select="rep_contact_details/phone_ext" />
                                                </span>
                                            </div>
                                            <div class="col-sm-027">
                                                <span class="labels"> Fax Number </span>
                                                <span class="activity_enrol">
                                                    <xsl:apply-templates select="rep_contact_details/fax_num" />
                                                </span>
                                            </div>
                                            <div class="col-sm-027">
                                                <span class="labels"> Email </span>
                                                <span class="activity_enrol">
                                                    <xsl:apply-templates select="rep_contact_details/email" />
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </xsl:for-each>
                </div>
            </div>
		</section>
	</xsl:template>


	<!-- Transaction Enrolment -->
	<xsl:template match="TRANSACTION_ENROL">
		<h1>Regulatory Enrolment Process</h1>
		<section>
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h2 class="panel-title">Transaction Information</h2>
				</div>

				<div class="panel-body">
					<div class="row">
						<div class="col-sm-099">
							<span class="labels"> Is this an eCTD transaction? </span>
							<span class="transaction_enrol"> <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="is_ectd"/> </xsl:call-template> </span>
						</div>
					</div>
					<div class="well well-sm" >
						<div class="panel panel-warning">
							<header class="panel-warning panel-heading" >
								<h3 class="panel-warning panel-title" > Life Cycle Management Table </h3>
							</header>

							<div class="panel-warning panel-body" >
								<TABLE border="1" cellspacing="2" cellpadding="2" style="table-layout: fixed; width: 100%">
									<TR>
										<TD style="word-wrap: break-word"> <span class="labels" style="text-align: center;"> Company ID </span> </TD>
										<TD style="word-wrap: break-word"> <span class="labels" style="text-align: center;"> Dossier Name </span> </TD>
										<TD style="word-wrap: break-word"> <span class="labels" style="text-align: center;"> Dossier ID </span> </TD>
									</TR>
									<TR>
										<TD style="word-wrap: break-word; text-align: center;"> <xsl:apply-templates select="ectd/company_id" /> </TD>
										<TD style="word-wrap: break-word; text-align: center;"> <xsl:apply-templates select="ectd/dossier_name" /> </TD>
										<TD style="word-wrap: break-word; text-align: center;"> <xsl:apply-templates select="ectd/dossier_id" /> </TD>
									</TR>
								</TABLE>
								<TABLE border="1" cellspacing="2" cellpadding="2" style="table-layout: fixed; width: 100%">
									<TR>
										<TD style="word-wrap: break-word" width="10%"> <span class="labels" style="text-align: center;"> Sequence Number </span> </TD>
										<TD style="word-wrap: break-word" width="10%"> <span class="labels" style="text-align: center;"> Date Submitted </span> </TD>
										<TD style="word-wrap: break-word" width="10%"> <span class="labels" style="text-align: center;"> Control Number </span> </TD>
										<TD style="word-wrap: break-word" width="10%"> <span class="labels" style="text-align: center;"> Regulatory Activity </span> </TD>
										<TD style="word-wrap: break-word" width="60%"> <span class="labels" style="text-align: center;"> Sequence Description </span> </TD>
									</TR>

									<xsl:for-each select="ectd/lifecycle_record">
										<TR>
										<TD style="word-wrap: break-word; text-align: center;" width="10%"> <xsl:apply-templates select="sequence_number" /> </TD>
										<TD style="word-wrap: break-word; text-align: center;" width="10%"> <xsl:apply-templates select="date_filed" /> </TD>
										<TD style="word-wrap: break-word; text-align: center;" width="10%"> <xsl:apply-templates select="control_number" /> </TD>
										<TD style="word-wrap: break-word; text-align: center;" width="10%"> <xsl:apply-templates select="sequence_activity_type" /> </TD>
										<TD style="word-wrap: break-word" width="60%"> <xsl:apply-templates select="sequence_concat" /> </TD>
										</TR>
									</xsl:for-each>
								</TABLE>
							</div>
						</div>
					</div>

					<div class="well well-sm" >
						<div class="row">
							<div class="col-sm-049">
								<span class="labels"> Is this solicited information? </span>
								<span class="transaction_enrol"> <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="is_solicited"/> </xsl:call-template> </span>
							</div>
							<xsl:if test="is_solicited = 'Y'">
								<div class="col-sm-049">
									<span class="labels"> Requester of Solicited Information </span>
									<span class="transaction_enrol"> <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="solicited_requester"/> </xsl:call-template> </span>
									<xsl:if test="solicited_requester = 'OTHER'"> <span class="transaction_enrol"> Placeholder </span> </xsl:if>
								</div>
							</xsl:if>
						</div>
					</div>

					<h4> Name of Regulatory Project Manager [if known]: </h4>

					<div class="well well-sm" >
						<div class="row">
							<div class="col-sm-049">
								<span class="labels"> Project Manager Name 1 </span>
								<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_project_manager1" /> </span>
							</div>
							<div class="col-sm-049">
								<span class="labels"> Project Manager Name 2 </span>
								<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_project_manager2" /> </span>
							</div>
						</div>
					</div>

				</div>
			</div>

			<div class="panel panel-primary">
				<div class="panel-heading">
					<h2 class="panel-title">Regulatory Activity Contact [for THIS Regulatory Activity]</h2>
				</div>

				<div class="panel-body">
					<div class="panel panel-warning">
						<header class="panel-warning panel-heading" >
							<h3 class="panel-warning panel-title" > Company Information: </h3>
						</header>

						<div class="panel-warning panel-body" >
							<div class="well well-sm" >
								<div class="row">
									<div class="col-sm-099">
										<span class="labels"> Company Name [Full Legal Name] </span>
										<span class="transaction_enrol"> <xsl:apply-templates select="company_name" /> </span>
									</div>
								</div>
							</div>

						</div>
					</div>

					<div class="panel panel-warning">
						<header class="panel-warning panel-heading" >
							<h3 class="panel-warning panel-title" > Address Information: </h3>
						</header>
						<div class="panel-warning panel-body" >
							<div class="well well-sm" >
								<div class="row">
									<div class="col-sm-099">
										<span class="labels"> Street / Suite </span>
										<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_activity_address/street_address" /> </span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-024">
										<span class="labels"> City / Town </span>
										<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_activity_address/city" /> </span>
									</div>
									<div class="col-sm-024">
										<span class="labels"> Province </span>
										<span class="transaction_enrol"> <xsl:choose><xsl:when test="(regulatory_activity_address/country = 'CAN') or (regulatory_activity_address/country = 'USA')"><xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="regulatory_activity_address/province_lov"/> </xsl:call-template></xsl:when><xsl:otherwise><xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="regulatory_activity_address/province_text"/> </xsl:call-template></xsl:otherwise></xsl:choose> </span>
									</div>
									<div class="col-sm-024">
										<span class="labels"> Country </span>
										<span class="transaction_enrol"> <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="regulatory_activity_address/country"/> </xsl:call-template> </span>
									</div>
									<div class="col-sm-024">
										<span class="labels"> Postal / ZIP Code </span>
										<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_activity_address/postal_code" /> </span>
									</div>
								</div>
							</div>

						</div>
					</div>

					<div class="panel panel-warning">
						<header class="panel-warning panel-heading" >
							<h3 class="panel-warning panel-title" > Company Representative [for THIS Regulatory Activity]: </h3>
						</header>
						<div class="panel-warning panel-body" >
							<div class="well well-sm" >
								<div class="row">
									<div class="col-sm-005">
										<span class="labels"> Salutation </span>
										<span class="transaction_enrol"> <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="regulatory_activity_contact/salutation"/> </xsl:call-template> </span>
									</div>
									<div class="col-sm-021">
										<span class="labels"> Given Name </span>
										<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_activity_contact/given_name" /> </span>
									</div>
									<div class="col-sm-005">
										<span class="labels"> Initials </span>
										<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_activity_contact/initials" /> </span>
									</div>
									<div class="col-sm-021">
										<span class="labels"> Surname </span>
										<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_activity_contact/surname" /> </span>
									</div>
									<div class="col-sm-021">
										<span class="labels"> Job Title </span>
										<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_activity_contact/job_title" /> </span>
									</div>
									<div class="col-sm-021">
										<span class="labels"> Language Correspondence </span>
										<span class="transaction_enrol"> <xsl:call-template name="Dropdown_Label"> <xsl:with-param name="input" select="regulatory_activity_contact/language_correspondance"/> </xsl:call-template> </span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-027">
										<span class="labels"> Phone Number </span>
										<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_activity_contact/phone_num" /> </span>
									</div>
									<div class="col-sm-016">
										<span class="labels"> Phone Extension </span>
										<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_activity_contact/phone_ext" /> </span>
									</div>
									<div class="col-sm-027">
										<span class="labels"> Fax Number </span>
										<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_activity_contact/fax_num" /> </span>
									</div>
									<div class="col-sm-027">
										<span class="labels"> Email </span>
										<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_activity_contact/email" /> </span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</xsl:template>

	<!-- String to Paragraph -->
	<xsl:template name="String_To_Paragraph">
		<xsl:param name="input" />
		<xsl:choose>
			<xsl:when test="contains($input, '&#10;')">
				<xsl:value-of select="substring-before($input, '&#10;')" /><br />
				<xsl:call-template name="String_To_Paragraph">
					<xsl:with-param name="input" select="substring-after($input, '&#10;')" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$input" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Dropdown Label Formatter-->
	<xsl:template name="Dropdown_Label">
		<xsl:param name="input" />
		<xsl:choose>
			<!-- Yes/No -->
			<xsl:when test="$input = 'Y'">
				<xsl:text disable-output-escaping="yes">Yes</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'N'">
				<xsl:text disable-output-escaping="yes">No</xsl:text>
			</xsl:when>

			<!-- Languages -->

			<xsl:when test="$input = 'en'">
				<xsl:text>English</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'fr'">
				<xsl:text>French</xsl:text>
			</xsl:when>

			<!-- Salutation -->

			<xsl:when test="$input = 'SALUT_DR'">
				<xsl:text>Dr.</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SALUT_MR'">
				<xsl:text>Mr.</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SALUT_MRS'">
				<xsl:text>Mrs.</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SALUT_MS'">
				<xsl:text>Ms.</xsl:text>
			</xsl:when>

			<!-- Provinces -->

			<xsl:when test="$input = 'AB'">
				<xsl:text>Alberta</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BC'">
				<xsl:text>British Columbia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MB'">
				<xsl:text>Manitoba</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NB'">
				<xsl:text>New Brunswick</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NL'">
				<xsl:text>Newfoundland and Labrador</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NS'">
				<xsl:text>Nova Scotia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NT'">
				<xsl:text>Northwest Territories</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NU'">
				<xsl:text>Nunavut</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ON'">
				<xsl:text>Ontario</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PE'">
				<xsl:text>Prince Edward Island</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'QC'">
				<xsl:text>Quebec</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SK'">
				<xsl:text>Saskatchewan</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'YT'">
				<xsl:text>Yukon</xsl:text>
			</xsl:when>

			<!-- Countries -->

			<xsl:when test="$input = 'AFG'">
				<xsl:text>Afghanistan</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ALA'">
				<xsl:text>Aland Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ALB'">
				<xsl:text>Albania</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'DZA'">
				<xsl:text>Algeria</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ASM'">
				<xsl:text>American Samoa</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'AND'">
				<xsl:text>Andorra</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'AGO'">
				<xsl:text>Angola</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'AIA'">
				<xsl:text>Anguilla</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ATA'">
				<xsl:text>Antarctica</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ATG'">
				<xsl:text>Antigua and Barbuda</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ARG'">
				<xsl:text>Argentina</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ARM'">
				<xsl:text>Armenia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ABW'">
				<xsl:text>Aruba</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'AUS'">
				<xsl:text>Australia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'AUT'">
				<xsl:text>Austria</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'AZE'">
				<xsl:text>Azerbaijan</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BHS'">
				<xsl:text>Bahamas</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BHR'">
				<xsl:text>Bahrain</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BGD'">
				<xsl:text>Bangladesh</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BRB'">
				<xsl:text>Barbados</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BLR'">
				<xsl:text>Belarus</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BEL'">
				<xsl:text>Belgium</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BLZ'">
				<xsl:text>Belize</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BEN'">
				<xsl:text>Benin</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BMU'">
				<xsl:text>Bermuda</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BTN'">
				<xsl:text>Bhutan</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BOL'">
				<xsl:text>Bolivia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BIH'">
				<xsl:text>Bosnia and Herzegovina</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BWA'">
				<xsl:text>Botswana</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BVT'">
				<xsl:text>Bouvet Island</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BRA'">
				<xsl:text>Brazil</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'VGB'">
				<xsl:text>British Virgin Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'IOT'">
				<xsl:text>British Indian Ocean Territory</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BRN'">
				<xsl:text>Brunei Darussalam</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BGR'">
				<xsl:text>Bulgaria</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BFA'">
				<xsl:text>Burkina Faso</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BDI'">
				<xsl:text>Burundi</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'KHM'">
				<xsl:text>Cambodia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CMR'">
				<xsl:text>Cameroon</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CAN'">
				<xsl:text>Canada</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CPV'">
				<xsl:text>Cape Verde</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CYM'">
				<xsl:text>Cayman Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CAF'">
				<xsl:text>Central African Republic</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'TCD'">
				<xsl:text>Chad</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CHL'">
				<xsl:text>Chile</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CHN'">
				<xsl:text>China</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'HKG'">
				<xsl:text>Hong Kong, Special Administrative Region of China</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MAC'">
				<xsl:text>Macao, Special Administrative Region of China</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CXR'">
				<xsl:text>Christmas Island</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CCK'">
				<xsl:text>Cocos (Keeling) Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'COL'">
				<xsl:text>Colombia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'COM'">
				<xsl:text>Comoros</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'COG'">
				<xsl:text>Congo (Brazzaville)</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'COD'">
				<xsl:text>Congo, Democratic Republic of the</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'COK'">
				<xsl:text>Cook Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CRI'">
				<xsl:text>Costa Rica</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CIV'">
				<xsl:text>Côte d'Ivoire</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'HRV'">
				<xsl:text>Croatia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CUB'">
				<xsl:text>Cuba</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CYP'">
				<xsl:text>Cyprus</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CZE'">
				<xsl:text>Czech Republic</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'DNK'">
				<xsl:text>Denmark</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'DJI'">
				<xsl:text>Djibouti</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'DMA'">
				<xsl:text>Dominica</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'DOM'">
				<xsl:text>Dominican Republic</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ECU'">
				<xsl:text>Ecuador</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'EGY'">
				<xsl:text>Egypt</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SLV'">
				<xsl:text>El Salvador</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GNQ'">
				<xsl:text>Equatorial Guinea</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ERI'">
				<xsl:text>Eritrea</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'EST'">
				<xsl:text>Estonia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ETH'">
				<xsl:text>Ethiopia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'FLK'">
				<xsl:text>Falkland Islands (Malvinas)</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'FRO'">
				<xsl:text>Faroe Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'FJI'">
				<xsl:text>Fiji</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'FIN'">
				<xsl:text>Finland</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'FRA'">
				<xsl:text>France</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GUF'">
				<xsl:text>French Guiana</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PYF'">
				<xsl:text>French Polynesia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ATF'">
				<xsl:text>French Southern Territories</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GAB'">
				<xsl:text>Gabon</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GMB'">
				<xsl:text>Gambia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GEO'">
				<xsl:text>Georgia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'DEU'">
				<xsl:text>Germany</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GHA'">
				<xsl:text>Ghana</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GIB'">
				<xsl:text>Gibraltar</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GRC'">
				<xsl:text>Greece</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GRL'">
				<xsl:text>Greenland</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GRD'">
				<xsl:text>Grenada</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GLP'">
				<xsl:text>Guadeloupe</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GUM'">
				<xsl:text>Guam</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GTM'">
				<xsl:text>Guatemala</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GGY'">
				<xsl:text>Guernsey</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GIN'">
				<xsl:text>Guinea</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GNB'">
				<xsl:text>Guinea-Bissau</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GUY'">
				<xsl:text>Guyana</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'HTI'">
				<xsl:text>Haiti</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'HMD'">
				<xsl:text>Heard Island and Mcdonald Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'VAT'">
				<xsl:text>Holy See (Vatican City State)</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'HND'">
				<xsl:text>Honduras</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'HUN'">
				<xsl:text>Hungary</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ISL'">
				<xsl:text>Iceland</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'IND'">
				<xsl:text>India</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'IDN'">
				<xsl:text>Indonesia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'IRN'">
				<xsl:text>Iran, Islamic Republic of</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'IRQ'">
				<xsl:text>Iraq</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'IRL'">
				<xsl:text>Ireland</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'IMN'">
				<xsl:text>Isle of Man</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ISR'">
				<xsl:text>Israel</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ITA'">
				<xsl:text>Italy</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'JAM'">
				<xsl:text>Jamaica</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'JPN'">
				<xsl:text>Japan</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'JEY'">
				<xsl:text>Jersey</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'JOR'">
				<xsl:text>Jordan</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'KAZ'">
				<xsl:text>Kazakhstan</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'KEN'">
				<xsl:text>Kenya</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'KIR'">
				<xsl:text>Kiribati</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PRK'">
				<xsl:text>Korea, Democratic People's Republic of</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'KOR'">
				<xsl:text>Korea, Republic of</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'KWT'">
				<xsl:text>Kuwait</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'KGZ'">
				<xsl:text>Kyrgyzstan</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'LAO'">
				<xsl:text>Lao PDR</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'LVA'">
				<xsl:text>Latvia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'LBN'">
				<xsl:text>Lebanon</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'LSO'">
				<xsl:text>Lesotho</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'LBR'">
				<xsl:text>Liberia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'LBY'">
				<xsl:text>Libya</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'LIE'">
				<xsl:text>Liechtenstein</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'LTU'">
				<xsl:text>Lithuania</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'LUX'">
				<xsl:text>Luxembourg</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MKD'">
				<xsl:text>Macedonia, Republic of</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MDG'">
				<xsl:text>Madagascar</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MWI'">
				<xsl:text>Malawi</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MYS'">
				<xsl:text>Malaysia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MDV'">
				<xsl:text>Maldives</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MLI'">
				<xsl:text>Mali</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MLT'">
				<xsl:text>Malta</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MHL'">
				<xsl:text>Marshall Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MTQ'">
				<xsl:text>Martinique</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MRT'">
				<xsl:text>Mauritania</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MUS'">
				<xsl:text>Mauritius</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MYT'">
				<xsl:text>Mayotte</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MEX'">
				<xsl:text>Mexico</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'FSM'">
				<xsl:text>Micronesia, Federated States of</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MDA'">
				<xsl:text>Moldova</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MCO'">
				<xsl:text>Monaco</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MNG'">
				<xsl:text>Mongolia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MNE'">
				<xsl:text>Montenegro</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MSR'">
				<xsl:text>Montserrat</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MAR'">
				<xsl:text>Morocco</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MOZ'">
				<xsl:text>Mozambique</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MMR'">
				<xsl:text>Myanmar</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NAM'">
				<xsl:text>Namibia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NRU'">
				<xsl:text>Nauru</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NPL'">
				<xsl:text>Nepal</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NLD'">
				<xsl:text>Netherlands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ANT'">
				<xsl:text>Netherlands Antilles</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NCL'">
				<xsl:text>New Caledonia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NZL'">
				<xsl:text>New Zealand</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NIC'">
				<xsl:text>Nicaragua</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NER'">
				<xsl:text>Niger</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NGA'">
				<xsl:text>Nigeria</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NIU'">
				<xsl:text>Niue</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NFK'">
				<xsl:text>Norfolk Island</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MNP'">
				<xsl:text>Northern Mariana Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NOR'">
				<xsl:text>Norway</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'OMN'">
				<xsl:text>Oman</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PAK'">
				<xsl:text>Pakistan</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PLW'">
				<xsl:text>Palau</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PSE'">
				<xsl:text>Palestinian Territory, Occupied</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PAN'">
				<xsl:text>Panama</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PNG'">
				<xsl:text>Papua New Guinea</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PRY'">
				<xsl:text>Paraguay</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PER'">
				<xsl:text>Peru</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PHL'">
				<xsl:text>Philippines</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PCN'">
				<xsl:text>Pitcairn</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'POL'">
				<xsl:text>Poland</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PRT'">
				<xsl:text>Portugal</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PRI'">
				<xsl:text>Puerto Rico</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'QAT'">
				<xsl:text>Qatar</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'REU'">
				<xsl:text>Réunion</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ROU'">
				<xsl:text>Romania</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'RUS'">
				<xsl:text>Russian Federation</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'RWA'">
				<xsl:text>Rwanda</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BLM'">
				<xsl:text>Saint-Barthélemy</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SHN'">
				<xsl:text>Saint Helena</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'KNA'">
				<xsl:text>Saint Kitts and Nevis</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'LCA'">
				<xsl:text>Saint Lucia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'MAF'">
				<xsl:text>Saint-Martin (French part)</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SPM'">
				<xsl:text>Saint Pierre and Miquelon</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'VCT'">
				<xsl:text>Saint Vincent and Grenadines</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'WSM'">
				<xsl:text>Samoa</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SMR'">
				<xsl:text>San Marino</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'STP'">
				<xsl:text>Sao Tome and Principe</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SAU'">
				<xsl:text>Saudi Arabia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SEN'">
				<xsl:text>Senegal</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SRB'">
				<xsl:text>Serbia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SYC'">
				<xsl:text>Seychelles</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SLE'">
				<xsl:text>Sierra Leone</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SGP'">
				<xsl:text>Singapore</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SVK'">
				<xsl:text>Slovakia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SVN'">
				<xsl:text>Slovenia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SLB'">
				<xsl:text>Solomon Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SOM'">
				<xsl:text>Somalia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ZAF'">
				<xsl:text>South Africa</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SGS'">
				<xsl:text>South Georgia and the South Sandwich Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SSD'">
				<xsl:text>South Sudan</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ESP'">
				<xsl:text>Spain</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'LKA'">
				<xsl:text>Sri Lanka</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SDN'">
				<xsl:text>Sudan</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SUR'">
				<xsl:text>Suriname *</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SJM'">
				<xsl:text>Svalbard and Jan Mayen Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SWZ'">
				<xsl:text>Swaziland</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SWE'">
				<xsl:text>Sweden</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CHE'">
				<xsl:text>Switzerland</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'SYR'">
				<xsl:text>Syrian Arab Republic (Syria)</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'TWN'">
				<xsl:text>Taiwan, Republic of China</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'TJK'">
				<xsl:text>Tajikistan</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'TZA'">
				<xsl:text>Tanzania *, United Republic of</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'THA'">
				<xsl:text>Thailand</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'TLS'">
				<xsl:text>Timor-Leste</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'TGO'">
				<xsl:text>Togo</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'TKL'">
				<xsl:text>Tokelau</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'TON'">
				<xsl:text>Tonga</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'TTO'">
				<xsl:text>Trinidad and Tobago</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'TUN'">
				<xsl:text>Tunisia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'TUR'">
				<xsl:text>Turkey</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'TKM'">
				<xsl:text>Turkmenistan</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'TCA'">
				<xsl:text>Turks and Caicos Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'TUV'">
				<xsl:text>Tuvalu</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'UGA'">
				<xsl:text>Uganda</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'UKR'">
				<xsl:text>Ukraine</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ARE'">
				<xsl:text>United Arab Emirates</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'GBR'">
				<xsl:text>United Kingdom</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'USA'">
				<xsl:text>United States of America</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'UMI'">
				<xsl:text>United States Minor Outlying Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'URY'">
				<xsl:text>Uruguay</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'UZB'">
				<xsl:text>Uzbekistan</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'VUT'">
				<xsl:text>Vanuatu</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'VEN'">
				<xsl:text>Venezuela (Bolivarian Republic of)</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'VNM'">
				<xsl:text>Viet Nam</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'VIR'">
				<xsl:text>Virgin Islands, US</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'WLF'">
				<xsl:text>Wallis and Futuna Islands</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ESH'">
				<xsl:text>Western Sahara</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'YEM'">
				<xsl:text>Yemen</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ZMB'">
				<xsl:text>Zambia</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'ZWE'">
				<xsl:text>Zimbabwe</xsl:text>
			</xsl:when>

			<!-- Section 2 - Animal Sources -->

			<xsl:when test="$input = 'AQUATIC_TYPE'">
				<xsl:text>Aquatic species such as fish, molluscs and crustacean:</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'AVIAN_TYPE'">
				<xsl:text>Avian such as chicken, turkey and duck:</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'BOVINE_TYPE'">
				<xsl:text>Bovine such as cattle, bison type:</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CANINE_TYPE'">
				<xsl:text>Canine type:</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CAPRINE_TYPE'">
				<xsl:text>Caprine such as goat type:</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'CERVIDAE_TYPE'">
				<xsl:text>Cervidae such as deer, elk (wapiti) and moose type:</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'EQUINE_TYPE'">
				<xsl:text>Equine such as horse type:</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'FELINE_TYPE'">
				<xsl:text>Feline such as cat type:</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'NONHUMANPRIMATE_TYPE'">
				<xsl:text>Non-human primate type:</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'OTHERANIMAL_TYPE'">
				<xsl:text>Other animal type:</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'OVINE_TYPE'">
				<xsl:text>Ovine type:</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'PORCINE_TYPE'">
				<xsl:text>Porcine such as pig type:</xsl:text>
			</xsl:when>
			<xsl:when test="$input = 'RODENT_TYPE'">
				<xsl:text>Rodents such as mouse, hamster, rat and rabbit type:</xsl:text>
			</xsl:when>



			<!-- OTHERWISE -->

			<xsl:otherwise>
				<xsl:value-of select="$input" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="no" name="Scenario1" userelativepaths="yes" externalpreview="no" url="HCREPDO_3343434_1.0.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
		          commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="true"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
		<scenario default="yes" name="Scenario2" userelativepaths="yes" externalpreview="no" url="DRAFTREPCO_0.2 (2).xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
		          commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="true"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template match="/"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->
