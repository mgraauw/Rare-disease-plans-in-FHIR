<!-- Translates the output of RetrieveProject (compiled) into a simpler XML format which serves as a base for next steps. -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    <xsl:output method="xml" indent="true"/>
    <!-- SDS, sickle cell, thalassemia codes -->
    <xsl:variable name="codes"  select="('811', '231214', '232')"/>
    <xsl:variable name="gsmap" select="doc('gstandaardmap.xml')"/>
    <xsl:template match="/">
        <RareConditions>
            <xsl:for-each select="//concept[terminologyAssociation[@codeSystem = '2.16.840.1.113883.2.4.3.46.10.4.1']/@code=$codes]">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </RareConditions>
    </xsl:template>

    <xsl:template match="concept[terminologyAssociation[@codeSystem = '2.16.840.1.113883.2.4.3.46.10.4.1']]">
            <RareCondition>
                <xsl:copy-of select="implementation/@shortName"/>
                <xsl:copy-of select="name"/>
                        <coding>
                            <system value="http://www.orpha.net"/>
                            <code value="ORPHA:{terminologyAssociation[@codeSystem='2.16.840.1.113883.2.4.3.46.10.4.1']/@code/string()}"/>
                            <display value="{terminologyAssociation[@codeSystem='2.16.840.1.113883.2.4.3.46.10.4.1']/@displayName/string()}"/>
                        </coding>
                <Diseases>
                    <xsl:for-each select="concept[contains(implementation/@shortName, 'ziekten')]/valueSet//concept">
                        <xsl:variable name="code" select="@code"/>
                        <xsl:for-each select="//concept[terminologyAssociation[@codeSystem = '2.16.840.1.113883.6.96'][@code=$code]]">
                            <xsl:call-template name="disease"/>
                        </xsl:for-each>
                    </xsl:for-each>
                </Diseases>
                <xsl:if test=".//concept[@codeSystem = '2.16.840.1.113883.6.254']">
                    <VragenLijst>
                        <title value="Vragenlijst activiteit en participatie voor {name[1]}"/>
                        <xsl:for-each select=".//concept[@codeSystem = '2.16.840.1.113883.6.254']">
                            <Vraag>
                                <coding>
                                    <system value="http://hl7.org/fhir/sid/icf-nl"/>
                                    <code value="{@code}"/>
                                    <display value="{@displayName}"/>
                                </coding>
                            </Vraag>
                        </xsl:for-each>
                    </VragenLijst>
                </xsl:if>
            </RareCondition>
    </xsl:template>

    <!-- Diseaeses -->
    <xsl:template name="disease">
            <xsl:variable name="shortName" select="implementation/@shortName/string()"/>
            <xsl:variable name="fullName" select="name[1]/string()"/>
                <Disease>
                    <xsl:copy-of select="implementation/@shortName"/>
                    <xsl:copy-of select="name"/>
                            <coding>
                                <system value="http://snomed.info/sct"/>
                                <code value="{terminologyAssociation[@codeSystem='2.16.840.1.113883.6.96']/@code/string()}"/>
                                <display value="{terminologyAssociation[@codeSystem='2.16.840.1.113883.6.96']/@displayName/string()}"/>
                            </coding>
                    <!-- Find any ATC codes, assume all are needed. -->
                    <Medicatie>
                    <xsl:for-each select=".//concept[@codeSystem = '2.16.840.1.113883.6.73']">
                        <MedicatieGebruik>
                            <title value="{@displayName}"/>
                            <xsl:variable name="code" select="@code"/>
                            <coding>
                                <system value="http://www.whocc.no/atc"/>
                                <code value="{$code}"/>
                                <display value="{@displayName}"/>
                                <systemName value="Anatomic Therapeutic Classification code (ATC)"/>
                            </coding>
                            <xsl:for-each select="$gsmap//atc[@code=$code]">
                                <!-- systemName is geen FHIR, toevoeging -->
                                <xsl:for-each select="gpk">
                                    <coding>
                                        <system value="urn:oid:2.16.840.1.113883.2.4.4.1"/>
                                        <code value="{@code/string()}"/>
                                        <display value="{@naam/string()}"/>
                                        <systemName value="G-standaard Generic product code (GPK)"/>
                                    </coding>
                                    <xsl:for-each select="prk">
                                        <coding>
                                            <system value="urn:oid:2.16.840.1.113883.2.4.4.10"/>
                                            <code value="{@code/string()}"/>
                                            <systemName value="G-standaard Prescription code (PRK)"/>
                                        </coding>
                                    </xsl:for-each>
                                    <xsl:for-each select="hpk">
                                        <coding>
                                            <system value="urn:oid:2.16.840.1.113883.2.4.4.7"/>
                                            <code value="{@code/string()}"/>
                                            <systemName value="G-standaard Trade product code (HPK)"/>
                                        </coding>
                                    </xsl:for-each>
                                    <xsl:for-each select="atkode">
                                        <coding>
                                            <system value="urn:oid:2.16.840.1.113883.2.4.4.8"/>
                                            <code value="{@code/string()}"/>
                                            <systemName value="KNMP article number (ATKODE)"/>
                                        </coding>
                                    </xsl:for-each>
                                </xsl:for-each>
                            </xsl:for-each>
                        </MedicatieGebruik>
                    </xsl:for-each>
                    </Medicatie>
                    <!-- Find any LOINC codes, assume all are needed. -->
                    <LabUitslagen>
                    <xsl:for-each select=".//concept[@codeSystem = '2.16.840.1.113883.6.1']">
                        <xsl:variable name="code" select="@code"/>
                        <LabUitslag>
                            <title value="{@displayName}"/>
                            <coding>
                                <system value="http://loinc.org"/>
                                <code value="{$code}"/>
                                <display value="{@displayName}"/>
                            </coding>
                        </LabUitslag>
                    </xsl:for-each>
                    </LabUitslagen>
                    <!-- A single Questionnaire per disease now -->
                    <xsl:if test=".//concept[@codeSystem = '2.16.840.1.113883.6.254']">
                        <VragenLijst>
                            <title value="Vragenlijst functies voor {name[1]}"/>
                            <xsl:for-each select=".//concept[@codeSystem = '2.16.840.1.113883.6.254']">
                                <Vraag>
                                    <coding>
                                        <system value="http://hl7.org/fhir/sid/icf-nl"/>
                                        <code value="{@code}"/>
                                        <display value="{@displayName}"/>
                                    </coding>
                                </Vraag>
                            </xsl:for-each>
                        </VragenLijst>
                    </xsl:if>
                </Disease>
    </xsl:template>
    
    <xsl:template match="*"> </xsl:template>
    <xsl:template match="@* | comment() | text()"/>
</xsl:stylesheet>
