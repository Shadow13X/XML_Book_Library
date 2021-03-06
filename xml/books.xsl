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
            <link rel="icon" type="image/x-icon" href="favicon.ico"/>
            <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500&amp;display=swap" rel="stylesheet"/>
            <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
            <link rel="stylesheet" href="../styles.3dd5b57524070775479c.css"/>
            <style>
                h2,h3{
                    text-align:center;
                    font-weight: 500 !important;
                }
                .container{
                    margin:20px 10%;
                }
            </style>
        </head>
        <body class="mat-typography"> 
            <div class="container">
            <h1 style="
                text-align:center;
                font-size: 40px !important;
                font-weight: 800 !important;
            "> <xsl:apply-templates select="description"/></h1>
            <h3> <xsl:apply-templates select="description/auteurs/auteur"/></h3>
            <xsl:apply-templates select="chapitres"/>
            </div>
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
