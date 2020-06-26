<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" />
    <xsl:template match="/">
        <html>
            <head>
                <title>BookShelve</title>
                <link type="text/css" rel="stylesheet" href="./lib/bootstrap/css/bootstrap.css" />
                <link type="text/css" rel="stylesheet" href="./style.css" />
                <script src="./lib/jquery/jquery.min.js"></script>
                <script src="./lib/bootstrap/js/bootstrap.min.js"></script>
                <script src="./lib/bootstrap/js/bootstrap.bundle.min.js"></script>
            </head>
            <body>
                <nav class="navbar navbar-default">
                    <div class="container-fluid" style="justify-content:space-between">
                        <div class="navbar-header">
                        <a class="navbar-brand" href="#">WebSiteName</a>
                        </div>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search"/>
                            <div class="input-group-btn">
                                <button class="btn btn-default" type="submit">
                                <i style="color:white;font-weight:500;transform:rotate(45)">&#9906;</i>
                                </button>
                            </div>
                        </div>
                    </div>
                </nav>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>
    <xsl:template match="books">
            <div class="row">
        <xsl:apply-templates />
            </div>
    </xsl:template>
    <xsl:template match="book">
        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card">
                <div class="card-header">
                    <xsl:value-of select="title" />
                </div>
                <div class="card-body">
                    Date of publishement: <xsl:value-of select="publish_date" /><br/>
                    Authors:
                    <ul>
                    <xsl:for-each select="authors/author">
                        <li><xsl:value-of select="@name" /></li>
                    </xsl:for-each>
                </ul>
                </div>
                <div class="card-footer">
                    <span>View</span>
                </div>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>