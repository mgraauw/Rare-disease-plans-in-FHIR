<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0" >
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="RareCondition">
        <xsl:result-document href="{concat('../basic/', @shortName/string(), '.html')}" method="html" indent="true">
            <html>
                <head>
                    <title><xsl:value-of select="name"/></title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
                </head>
                <body>
                    <div class="container-fluid">
                        <h1>
                            <xsl:value-of select="name"/>
                        </h1>
                        <table class="table-bordered">
                            <xsl:call-template name="th"/>
                            <tbody>
                                <xsl:apply-templates select="coding"/>
                            </tbody>
                        </table>
                        <h1>Diseases</h1>
                        <ol>
                            <xsl:for-each select=".//Disease">
                                <li><xsl:value-of select="name"/></li>
                            </xsl:for-each>
                        </ol>
                        <xsl:apply-templates select="Diseases/Disease"/>
                        <xsl:if test="VragenLijst">
                            <h3>Vragenlijst <xsl:value-of select="name"/></h3>
                            <xsl:value-of select="VragenLijst/title/@value/string()"/>
                            <table class="table-bordered table-striped">
                                <xsl:call-template name="th"/>
                                <tbody>
                                    <xsl:for-each select="VragenLijst/Vraag">
                                        <xsl:apply-templates/>
                                    </xsl:for-each>
                                </tbody>
                            </table>
                        </xsl:if>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="Disease">
        <xsl:variable name="disease" select="name"/>
        <h2>
            <xsl:value-of select="$disease"/>
        </h2>
        <table class="table-bordered">
            <xsl:call-template name="th"/>
            <tbody>
                <xsl:apply-templates select="coding"/>
            </tbody>
        </table>
        <xsl:if test=".//MedicatieGebruik">
            <h3>Medicatie <xsl:value-of select="$disease"/></h3>
            <table class="table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Medicatie</th>
                        <th>code</th>
                        <th>display</th>
                        <th>system</th>
                        <th>system name</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select=".//MedicatieGebruik/coding">
                        <tr>
                            <td>
                                <xsl:value-of select="preceding-sibling::title/@value/string()"/>
                            </td>
                            <td>
                                <xsl:value-of select="code/@value/string()"/>
                            </td>
                            <td>
                                <xsl:value-of select="display/@value/string()"/>
                            </td>
                            <td>
                                <xsl:value-of select="system/@value/string()"/>
                            </td>
                            <xsl:if test="systemName">
                                <td>
                                    <xsl:value-of select="systemName/@value/string()"/>
                                </td>
                            </xsl:if>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </xsl:if>

        <xsl:if test=".//LabUitslag">
            <h3>LabUitslagen <xsl:value-of select="$disease"/></h3>
            <table class="table-bordered table-striped">
                <xsl:call-template name="th"/>
                <tbody>
                    <xsl:for-each select=".//LabUitslag">
                        <xsl:apply-templates/>
                    </xsl:for-each>
                </tbody>
            </table>
        </xsl:if>

        <xsl:if test=".//Vraag">
            <h3>Vragenlijst <xsl:value-of select="$disease"/></h3>
            <xsl:value-of select="VragenLijst/title/@value/string()"/>
            <table class="table-bordered table-striped">
                <xsl:call-template name="th"/>
                <tbody>
                    <xsl:for-each select=".//Vraag">
                        <xsl:apply-templates/>
                    </xsl:for-each>
                </tbody>
            </table>
        </xsl:if>
    </xsl:template>

    <xsl:template name="th">
        <thead>
            <tr>
                <th>code</th>
                <th>display</th>
                <th>system</th>
            </tr>
        </thead>
    </xsl:template>

    <xsl:template match="coding">
        <tr>
            <td>
                <xsl:value-of select="code/@value/string()"/>
            </td>
            <td>
                <xsl:value-of select="display/@value/string()"/>
            </td>
            <td>
                <xsl:value-of select="system/@value/string()"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="@* | node()">
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>
