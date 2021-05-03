<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    <xsl:output method="xml" indent="true"/>
    <xsl:template match="/">
        <xsl:apply-templates select="dataset//concept"/>
        <xsl:apply-templates select="//valueSet//concept"/>
    </xsl:template>
    <!-- Make a PlanDefintion for SDS, 811 -->
    <xsl:template match="concept[terminologyAssociation[@codeSystem = '2.16.840.1.113883.2.4.3.46.10.4.1']/@code='811']">
        <xsl:variable name="shortName" select="implementation/@shortName/string()"/>
        <xsl:variable name="fullName" select="name[1]/string()"/>
        <xsl:result-document method="xml" indent="true" href="../xml/plandefinition-{$shortName}.xml">
            <PlanDefinition xmlns="http://hl7.org/fhir">
                <id value="rare-condition-{$shortName}"/>
                <language value="{/dataset/name[1]/@language/string()}"/>
                <text>
                    <status value="empty"/>
                    <div xmlns="http://www.w3.org/1999/xhtml"> TODO </div>
                </text>
                <url value="http://rarecare.world/PlanDefinition/{$shortName}"/>
                <identifier>
                    <use value="official"/>
                    <value value="{$shortName}-plan"/>
                </identifier>
                <version value="0.1"/>
                <title value="{$fullName} Management"/>
                <type>
                    <coding>
                        <system value="http://terminology.hl7.org/CodeSystem/plan-definition-type"/>
                        <code value="clinical-protocol"/>
                        <display value="Clinical Protocol"/>
                    </coding>
                </type>
                <status value="draft"/>
                <subjectCodeableConcept>
                    <coding>
                        <system value="http://hl7.org/fhir/resource-types"/>
                        <code value="Patient"/>
                        <display value="Patient"/>
                    </coding>
                </subjectCodeableConcept>
                <date value="{substring(string(current-date()), 1, 10)}"/>
                <publisher value="Stichting Rare Care World"/>
                <contact>
                    <telecom>
                        <system value="url"/>
                        <value value="https://rarecare.world"/>
                    </telecom>
                </contact>
                <description value="{$fullName} personal management plan."/>
                <!-- PlanDefinition.useContext
          The content was developed with a focus and intent of supporting the contexts that are listed. These contexts may be general categories (gender, age, ...) 
          or may be references to specific programs (insurance plans, studies, ...) and may be used to assist with indexing and searching for appropriate plan 
          definition instances. 
       
       Evt. gebruiken voor inderdaad leeftijd etc. -->
                <!--<purpose value="Doel van het plan"/>-->
                <topic>
                    <coding>
                        <system value="http://terminology.hl7.org/CodeSystem/definition-topic"/>
                        <code value="treatment"/>
                        <display value="Treatment"/>
                    </coding>
                </topic>
                <relatedArtifact>
                    <type value="justification"/>
                    <url value="https://rarecare.world/general-medical-guideline/{$shortName}"/>
                </relatedArtifact>
                <!--<relatedArtifact>
                    <type value="justification"/>
                    <url value="https://rarecare.world/patient-organisation/shwachman-syndrome-support-holland"/>
                </relatedArtifact>-->
                <goal>
                    <description>
                        <text value="Shwachman Diamond Syndrome management"/>
                    </description>
                    <addresses>
                        <coding>
                            <system value="http://www.orpha.net"/>
                            <code value="ORPHA:{terminologyAssociation[@codeSystem='2.16.840.1.113883.2.4.3.46.10.4.1']/@code/string()}"/>
                            <display value="{terminologyAssociation[@codeSystem='2.16.840.1.113883.2.4.3.46.10.4.1']/@displayName/string()}"/>
                        </coding>
                    </addresses>
                </goal>
                <!-- TODO: search on concept termAssoc, not substring -->
                <xsl:for-each select="concept[contains(implementation/@shortName, 'ziekten')]/valueSet//concept">
                    <xsl:variable name="code" select="@code"/>
                    <xsl:variable name="planname" select="//concept[terminologyAssociation[@codeSystem = '2.16.840.1.113883.6.96']/@code = $code]/implementation/@shortName/string()"/>
                    <xsl:if test="$planname">
                        <action>
                            <title value="{name[1]/string()} Management"/>
                            <definitionCanonical value="http://rarecare.world/PlanDefinition/{$planname}"/>
                        </action>
                    </xsl:if>
                </xsl:for-each>
            </PlanDefinition>
        </xsl:result-document>
    </xsl:template>
    <!-- Diseaeses -->
    <xsl:template match="concept[@id = '2.16.840.1.113883.2.4.3.11.60.52.2.182']">
        <xsl:for-each select="concept[terminologyAssociation/@codeSystem = '2.16.840.1.113883.6.96']">
            <xsl:variable name="shortName" select="implementation/@shortName/string()"/>
            <xsl:variable name="fullName" select="name[1]/string()"/>
            <xsl:result-document method="xml" indent="true" href="../xml/plandefinition-{$shortName}.xml">
                <PlanDefinition xmlns="http://hl7.org/fhir">
                    <id value="disease-{$shortName}"/>
                    <language value="{/dataset/name[1]/@language/string()}"/>
                    <text>
                        <status value="empty"/>
                        <div xmlns="http://www.w3.org/1999/xhtml"> TODO </div>
                    </text>
                    <url value="http://rarecare.world/PlanDefinition/{$shortName}"/>
                    <identifier>
                        <use value="official"/>
                        <value value="{$shortName}-plan"/>
                    </identifier>
                    <version value="0.1"/>
                    <title value="{$fullName} Management"/>
                    <type>
                        <coding>
                            <system value="http://terminology.hl7.org/CodeSystem/plan-definition-type"/>
                            <code value="clinical-protocol"/>
                            <display value="Clinical Protocol"/>
                        </coding>
                    </type>
                    <status value="draft"/>
                    <subjectCodeableConcept>
                        <coding>
                            <system value="http://hl7.org/fhir/resource-types"/>
                            <code value="Patient"/>
                            <display value="Patient"/>
                        </coding>
                    </subjectCodeableConcept>
                    <date value="{substring(string(current-date()), 1, 10)}"/>
                    <publisher value="Stichting Rare Care World"/>
                    <contact>
                        <telecom>
                            <system value="url"/>
                            <value value="https://rarecare.world"/>
                        </telecom>
                    </contact>
                    <description value="{$fullName} personal management plan."/>
                    <topic>
                        <coding>
                            <system value="http://terminology.hl7.org/CodeSystem/definition-topic"/>
                            <code value="treatment"/>
                            <display value="Treatment"/>
                        </coding>
                    </topic>
                    <relatedArtifact>
                        <type value="documentation"/>
                        <url value="https://rarecare.world/disease/{$shortName}"/>
                    </relatedArtifact>
                    <goal>
                        <description>
                            <text value="{$fullName} management"/>
                        </description>
                        <addresses>
                            <coding>
                                <system value="http://snomed.info/sct"/>
                                <code value="{terminologyAssociation[@codeSystem='2.16.840.1.113883.6.96']/@code/string()}"/>
                                <display value="{terminologyAssociation[@codeSystem='2.16.840.1.113883.6.96']/@displayName/string()}"/>
                            </coding>
                        </addresses>
                    </goal>
                    <!-- Find any ATC codes, assume all are needed. -->
                    <xsl:for-each select=".//concept[@codeSystem = '2.16.840.1.113883.6.73']">
                        <action>
                            <title value="Medication {@displayName}"/>
                            <definitionUri value="activity-definition-atc-{@code}"/>
                        </action>
                    </xsl:for-each>
                    <!-- Find any LOINC codes, assume all are needed. -->
                    <xsl:for-each select=".//concept[@codeSystem = '2.16.840.1.113883.6.1']">
                        <action>
                            <title value="Measurement {@displayName}"/>
                            <definitionUri value="activity-definition-loinc-{@code}"/>
                        </action>
                    </xsl:for-each>
                    <!-- A single Questionnaire per disease now -->
                    <xsl:if test=".//concept[@codeSystem = '2.16.840.1.113883.6.254']">
                        <action>
                            <title value="Questionnaire for {name[1]}"/>
                            <definitionUri value="questionnaire-{$shortName}"/>
                        </action>
                    </xsl:if>
                </PlanDefinition>
            </xsl:result-document>
            
            <xsl:if test=".//concept[@codeSystem = '2.16.840.1.113883.6.254']">
                <xsl:result-document method="xml" indent="true" href="../xml/questionnaire-{$shortName}.xml">
                    <Questionnaire xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://hl7.org/fhir">
                        <id value="questionnaire-{$shortName}"/>
                        <text>
                            <status value="generated"/>
                            <div xmlns="http://www.w3.org/1999/xhtml">Questionnaire for <xsl:value-of select="name[1]"/></div>
                        </text>
                        <name value="questionnaire-{$shortName}"/>
                        <title value="Vragenlijst voor {name[1]}"/>
                        <status value="draft"/>
                        <subjectType value="Patient"/>
                        <date value="{substring(string(current-date()), 1, 10)}"/>
                        <item>
                            <linkId value="{$shortName}"/>
                            <text value="{name[1]}"/>
                            <type value="group"/>
                            <required value="true"/>
                            <xsl:for-each select=".//concept[@codeSystem = '2.16.840.1.113883.6.254']">
                                <item>
                                    <linkId value="{@code}"/>
                                    <text value="{@displayName}"/>
                                    <type value="choice"/>
                                    <required value="false"/>
                                    <answerOption>
                                        <valueCoding>
                                            <system value="http://hl7.org/fhir/sid/icf-nl"/>
                                            <code value="{@code}.0"/>
                                            <xsl:choose>
                                                <xsl:when test="substring(@code, 1, 1) = 'b'">
                                                    <display value="Geen stoornis (0-5%)"/>
                                                </xsl:when>
                                                <xsl:when test="substring(@code, 1, 1) = 'd'">
                                                    <display value="Geen moeite"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <display value="Fout: Onjuiste ICF code"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </valueCoding>
                                    </answerOption>
                                    <answerOption>
                                        <valueCoding>
                                            <system value="http://hl7.org/fhir/sid/icf-nl"/>
                                            <code value="{@code}.1"/>
                                            <xsl:choose>
                                                <xsl:when test="substring(@code, 1, 1) = 'b'">
                                                    <display value="Lichte stoornis (5-24%)"/>
                                                </xsl:when>
                                                <xsl:when test="substring(@code, 1, 1) = 'd'">
                                                    <display value="Lichte moeite"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <display value="Fout: Onjuiste ICF code"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </valueCoding>
                                    </answerOption>
                                    <answerOption>
                                        <valueCoding>
                                            <system value="http://hl7.org/fhir/sid/icf-nl"/>
                                            <code value="{@code}.2"/>
                                            <xsl:choose>
                                                <xsl:when test="substring(@code, 1, 1) = 'b'">
                                                    <display value="Matige stoornis (25-49%)"/>
                                                </xsl:when>
                                                <xsl:when test="substring(@code, 1, 1) = 'd'">
                                                    <display value="Matige moeite"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <display value="Fout: Onjuiste ICF code"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </valueCoding>
                                    </answerOption>
                                    <answerOption>
                                        <valueCoding>
                                            <system value="http://hl7.org/fhir/sid/icf-nl"/>
                                            <code value="{@code}.3"/>
                                            <xsl:choose>
                                                <xsl:when test="substring(@code, 1, 1) = 'b'">
                                                    <display value="Ernstige stoornis (50-95%)"/>
                                                </xsl:when>
                                                <xsl:when test="substring(@code, 1, 1) = 'd'">
                                                    <display value="Ernstige moeite"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <display value="Fout: Onjuiste ICF code"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </valueCoding>
                                    </answerOption>
                                    <answerOption>
                                        <valueCoding>
                                            <system value="http://hl7.org/fhir/sid/icf-nl"/>
                                            <code value="{@code}.4"/>
                                            <xsl:choose>
                                                <xsl:when test="substring(@code, 1, 1) = 'b'">
                                                    <display value="Volledige stoornis (96-100%)"/>
                                                </xsl:when>
                                                <xsl:when test="substring(@code, 1, 1) = 'd'">
                                                    <display value="Volledige moeite"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <display value="Fout: Onjuiste ICF code"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </valueCoding>
                                    </answerOption>
                                    <answerOption>
                                        <valueCoding>
                                            <system value="http://hl7.org/fhir/sid/icf-nl"/>
                                            <code value="{@code}.8"/>
                                            <display value="niet gespecificeerd"/>
                                        </valueCoding>
                                    </answerOption>
                                    <answerOption>
                                        <valueCoding>
                                            <system value="http://hl7.org/fhir/sid/icf-nl"/>
                                            <code value="{@code}.9"/>
                                            <display value="niet van toepassing"/>
                                        </valueCoding>
                                    </answerOption>
                                </item>
                            </xsl:for-each>
                        </item>
                    </Questionnaire>
                </xsl:result-document>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="concept[@codeSystem = '2.16.840.1.113883.6.1']">
        <xsl:variable name="code" select="@code"/>
        <!-- Skip if another code has been processed -->
        <xsl:if test="not(preceding::concept[@codeSystem = '2.16.840.1.113883.6.1'][@code = $code])">
            <xsl:result-document method="xml" indent="true" href="../xml/observation-definition-loinc-{$code}.xml">
                <ObservationDefinition xmlns="http://hl7.org/fhir">
                    <id value="observation-definition-loinc-{$code}"/>
                    <text>
                        <status value="generated"/>
                        <div xmlns="http://www.w3.org/1999/xhtml">Observation for <xsl:value-of select="@displayName"/></div>
                    </text>
                    <code>
                        <coding>
                            <system value="http://loinc.org"/>
                            <code value="{$code}"/>
                            <display value="{@displayName}"/>
                        </coding>
                    </code>
                </ObservationDefinition>
            </xsl:result-document>
            <xsl:result-document method="xml" indent="true" href="../xml/activity-definition-loinc-{$code}.xml">
                <ActivityDefinition xmlns="http://hl7.org/fhir">
                    <id value="activity-definition-loinc-{$code}"/>
                    <text>
                        <status value="generated"/>
                        <div xmlns="http://www.w3.org/1999/xhtml">Activity Definition for <xsl:value-of select="@displayName"/></div>
                    </text>
                    <url value="https://rarecare.world/{$code}"/>
                    <status value="draft"/>
                    <description value="{@displayName} Measurement"/>
                    <kind value="ServiceRequest"/>
                    <code>
                        <text value="{@displayName}"/>
                    </code>
                    <observationResultRequirement>
                        <reference value="observation-definition-{$code}"/>
                    </observationResultRequirement>
                </ActivityDefinition>
            </xsl:result-document>
        </xsl:if>
    </xsl:template>
    <xsl:template match="concept[@codeSystem = '2.16.840.1.113883.6.73']">
        <xsl:variable name="code" select="@code"/>
        <!-- Skip if another code has been processed -->
        <xsl:if test="not(preceding::concept[@codeSystem = '2.16.840.1.113883.6.73'][@code = $code])">
            <xsl:result-document method="xml" indent="true" href="../xml/activity-definition-atc-{$code}.xml">
                <ActivityDefinition xmlns="http://hl7.org/fhir">
                    <id value="activity-definition-atc-{$code}"/>
                    <text>
                        <status value="generated"/>
                        <div xmlns="http://www.w3.org/1999/xhtml">Activity Definition for <xsl:value-of select="@displayName"/></div>
                    </text>
                    <url value="https://rarecare.world/{$code}"/>
                    <status value="draft"/>
                    <description value="{@displayName} Medication"/>
                    <kind value="MedicationRequest"/>
                    <code>
                        <text value="{@displayName}"/>
                    </code>
                    <productCodeableConcept>
                        <coding>
                            <system value="http://www.whocc.no/atc"/>
                            <code value="{@code}"/>
                            <display value="{@displayName}"/>
                        </coding>
                    </productCodeableConcept>
                </ActivityDefinition>
            </xsl:result-document>
        </xsl:if>
    </xsl:template>
    <xsl:template match="*"> </xsl:template>
    <xsl:template match="@* | comment() | text()"/>
</xsl:stylesheet>
