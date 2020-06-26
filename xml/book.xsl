<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" />
    <xsl:template match="/">
        <html>
            <xsl:apply-templates/>
        </html>
    </xsl:template>

    <xsl:template match="livre">
        <head>
            <title>
                <xsl:apply-templates select="description"/>
            </title>
        </head>
        <body> 
            <h1> <xsl:apply-templates select="description"/></h1>
            <h4> <xsl:apply-templates select="description/auteurs/auteur"/></h4>
            <xsl:apply-templates select="chapitres"/>
        </body>
    </xsl:template>
    <xsl:template match="chapitres">
        <xsl:apply-templates select="chapitre"/>
    </xsl:template>
    <xsl:template match="description">
        <xsl:value-of select="titre" />
    </xsl:template>
    <xsl:template match="description/auteurs/auteur">
        <xsl:value-of select="concat(prenom,' ',nom)" />
    </xsl:template>

    <xsl:template match="chapitre">
        <h2><xsl:value-of select="@titre" /></h2><br/>
        <xsl:for-each select="paragraphes/paragraphe">
            <div>
                <xsl:value-of select="." />
            </div>
            <br />
        </xsl:for-each>

    </xsl:template>
</xsl:stylesheet>