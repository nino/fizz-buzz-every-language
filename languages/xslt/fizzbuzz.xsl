<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text"/>

  <xsl:template name="fizzbuzz">
    <xsl:param name="i"/>
    <xsl:choose>
      <xsl:when test="$i mod 15 = 0">FizzBuzz</xsl:when>
      <xsl:when test="$i mod 3 = 0">Fizz</xsl:when>
      <xsl:when test="$i mod 5 = 0">Buzz</xsl:when>
      <xsl:otherwise><xsl:value-of select="$i"/></xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#10;</xsl:text>
    <xsl:if test="$i &lt; 100">
      <xsl:call-template name="fizzbuzz">
        <xsl:with-param name="i" select="$i + 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template match="/">
    <xsl:call-template name="fizzbuzz">
      <xsl:with-param name="i" select="1"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
