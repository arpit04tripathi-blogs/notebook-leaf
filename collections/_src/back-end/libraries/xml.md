---
layout: post
title: XML (eXtensible Markup Language)
permalink: /xml
---

- TOC
  {:toc}

---

# Introduction

- a simple and flexible markup language.
- It is universal standard for information interchange.
- XML documents can be created and used in any language.
- XML technology facilitates you to create your own markup language.
- Xml (eXtensible Markup Language) is a mark up language.
- XML is designed to store and transport data.
- Xml was released in late 90’s. it was created to provide an easy to use and store self describing data.
- XML became a W3C Recommendation on February 10, 1998.
- XML is not a replacement for HTML.
- XML is designed to be self-descriptive.
- XML is designed to carry data, not to display data.
- XML tags are not predefined. You must define your own tags.
- XML is platform independent and language independent.
- Self-describing data is the data that describes both its content and structure.

#### What is mark-up language?

- A mark up language is a modern system for highlight or underline a document.
- Students often underline or highlight a passage to revise easily, same in the sense of modern mark up language highlighting or underlining is replaced by tags.

#### Why xml?

- Platform Independent and Language Independent.
- international acceptance, Many corporation use XML interfaces for databases, programming, office application mobile phones and more.

| HTML                              | XML                                                                |
| --------------------------------- | ------------------------------------------------------------------ |
| to display data                   | to transport and store data.                                       |
| focuses on how data looks         | It focuses on what data is                                         |
| HTML is a markup language itself. | XML provides a framework to define markup languages.               |
| not case sensitive.               | case sensitive.                                                    |
| HTML is a presentation language.  | XML is neither a presentation language nor a programming language. |

## XML Structure

![xml-structure.png]({{site.cdn}}/webservices/xml/xml-structure.png)

| Benefits of XML  |                                                                                                                                                                                                                   |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Simplicity       | easy to read and understand                                                                                                                                                                                       |
| Openness         | W3C standard, endorsed by software industry market leaders.                                                                                                                                                       |
| Extensibility    | extensible, has no fixed set of tags. You can define them as you need.                                                                                                                                            |
| Self-descriptive | XML documents do not need special schema set-up like traditional databases to store data. XML documents can be stored without such definitions, because they contain metadata in the form of tags and attributes. |
| Scalable         | XML is not in binary format so you can create and edit files with anything and it is also easy to debug.                                                                                                          |
| Fast access      | XML documents are arranged in hierarchical form so it is comparatively faster.                                                                                                                                    |

### XML DOM

- DOM - Document Object Model
- used to describe the logical structure of XML document. It is a hierarchical model that provides a way to access and manipulate an XML document.
- DOM methods and objects can be used with any languages like C#, VB, JavaScript and VB Script.

### SAX in XML

- SAX - Simple API for XML.
- sequential access parser.
- It is a simple API for XML which provides a mechanism for reading data from an XML document. It is an alternative of DOM.
- DOM operates on the documents as whole, SAX parsers operate on each piece of the XML document sequentially.
- SAX has no formal specification like DOM and consumes less memory. But it can be used to read the XML document only not write.

### XSNL

XSNL is an XML search neutral language. This language acts between the meta search interface and targeted system.

### Well formed XML document

A syntactically correct document is called well formed XML document. A well formed XML document must follow the XML?s basic rules of syntax:

- It must have a closing tag.
- The closing tag must exactly match the open tag: XML is case sensitive.
- All elements should be included within a single root tag.
- Child elements must be closed within parent tag.

### valid XML document

A structurally correct element is called a valid XML document. It should follow some predefined rules of a specific type of document. These rules determine the type of data that each part of the document can contain. These rules can be written by the author of an XML document or someone other.

**Note**: _A valid XML document may be well-formed but a well-formed XML document may not be valid._

### DTD

- DTD - Document Type Definition.
- It defines a leading building block of an XML document.
- It defines:
  - Names of elements
  - How and where they can be used
  - Element attributes
  - Proper nesting

To apply a DTD to an XML document, you can:

- Use the DTD element definition within the XML document itself.
- Provide a DTD as a separate file and reference its name in XML document.

### Basic rules to write XML document

- It should have a root element.
- All tags must be closed.
- Spaces are not allowed in tag names.
- All tags must be nested properly.
- XML tags are case sensitive.
- Use the attribute values within quotes.
- Whitespace is preserved in XML.

### XSL

- XSL : Extensible Stylesheet Language.
- It is a language for expressing stylesheets. These stylesheets are like CSS which describes how to display an XML document of a given type.

#### XML schema

- XML schema is a language which is used for expressing constraint about XML documents. There are so many schema languages which are used now a days for example Relax- NG and XSD (XML schema definition).
- An XML schema is used to define the structure of an XML document. It is like DTD but provides more control on XML structure.

#### Checking Validation

- An XML document is called "well-formed" if it contains the correct syntax.
- A well-formed and valid XML document is one which have been validated against Schema.
- Visit http://www.xmlvalidation.com to validate the XML file against schema or DTD.

```xml
<!-- XML Schema Example -->
<!-- employee.xsd -->
<?xml version="1.0"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
    targetNamespace="http://www.javatpoint.com"
    xmlns="http://www.javatpoint.com"
    elementFormDefault="qualified">

    <xs:element name="employee"><!-- defines element named employee -->
      <xs:complexType>  <!-- defines 'employee' is complex type -->
        <xs:sequence> <!-- defines complex type is a sequence of elements -->
          <xs:element name="firstname" type="xs:string"/>  <!-- defines element 'firstname' is of string/text type -->
          <xs:element name="lastname" type="xs:string"/>
          <xs:element name="email" type="xs:string"/>
        </xs:sequence>
      </xs:complexType>
    </xs:element>
</xs:schema>
```

```xml
<!-- employee.xml -->
<?xml version="1.0"?>
<employee xmlns="http://www.javatpoint.com"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.javatpoint.com employee.xsd">

  <firstname>vimal</firstname>
  <lastname>jaiswal</lastname>
  <email>vimal@javatpoint.com</email>
</employee>
```

### XML Schema Data types

- simpleType
  - The simpleType allows you to have text-based elements. It contains less attributes, child elements, and cannot be left empty.
- complexType
  - The complexType allows you to hold multiple attributes and elements. It can contain additional sub elements and can be left empty.

### XPath in XML

- XPath is a technology used in XML.
- It is used to retrieve elements from XML documents.
- XPath expressions can be used to locate and retrieve elements, attributes and values from XML files because XML documents are structured. It is similar to SQL.
- As SQL is used to retrieve data from database, XPath is used to retrieve data from XML.

### XSLT

- XSLT is a popular XML technology which is used to transform one XML file to other format like HTML etc.
- XSLT is like a language which has its own syntax, functions and operator to transform XML documents.
- XSLT is also used to display data present in XML files as HTML pages.

| DTD                                      | XSD                                                           |
| ---------------------------------------- | ------------------------------------------------------------- |
| Document Type Definition.                | XML Schema Definition.                                        |
| derived from SGML syntax.                | written in XML.                                               |
| doesn't support datatypes.               | supports datatypes for elements and attributes.               |
| doesn't support namespace.               | supports namespace.                                           |
| doesn't define order for child elements. | defines order for child elements.                             |
| not extensible.                          | extensible.                                                   |
| not simple to learn.                     | simple to learn because you don't need to learn new language. |
| provides less control on XML structure.  | provides more control on XML structure.                       |

### XPOINTER.

- XPOINTER is used to point data within XML document.
- It is used to locate the particular part of the XML document. It is a W3C recommendation.
- example:

```
address.xml#pointer(/ descendant ::streetnumber[@id =9])
```

In this example, XPOINTER points "streetnumber = 9" in "address.xml".

### XML encoding error

There are two types of XML encoding errors:

1. An invalid character was found in text content.
2. Switching from current encoding to specified encoding not supported.

- These errors occur because XML document can contain non ASCII characters like Norwegian and French.
- These errors can be avoided by specifying the XML encoding Unicode.

### different XML API's

- Tree-based API
  - It compiles an XML document in a tree like structure and loads it into the memory. You can traverse and change the tree structure. Tree based API's are useful for a wide range of applications. Example of tree-based API is DOM parser.
- Event-based API
  - An event based API provides the reports to an application about the parsing event. It uses a set of built-in call back functions. Example of event-based API is SAX parser.

### XmlReader class

The XmlrReader class represents a reader that provides fast, noncached, forward-only access to XML data.  
You need to import the following namespaces to work with XmlReader class in .NET.

- In VB: Imports System.Xml
- In C#: using System.Xml;

### CDATA and PCDATA

| CDATA                   | PCDATA                 |
| ----------------------- | ---------------------- |
| unparsed character data | parsed character data. |

CDATA: (Unparsed Character data): CDATA contains the text which is not parsed further in an XML document. Tags inside the CDATA text are not treated as markup and entities will not be expanded.

```xml
<?xml version="1.0"?>
<!DOCTYPE employee SYSTEM "employee.dtd">
<employee>
<![CDATA[
  <firstname>vimal</firstname>
  <lastname>jaiswal</lastname>
  <email>vimal@javatpoint.com</email>
]]>
</employee>
```

In the above CDATA example, CDATA is used just after the element employee to make the data/text unparsed, so it will give the value of employee:

```
<firstname>vimal</firstname><lastname>jaiswal</lastname><email>vimal@javatpoint.com</email>
```

PCDATA:
(Parsed Character Data): XML parsers are used to parse all the text in an XML document. PCDATA stands for Parsed Character data. PCDATA is the text that will be parsed by a parser. Tags inside the PCDATA will be treated as markup and entities will be expanded.

In other words you can say that a parsed character data means the XML parser examine the data and ensure that it doesn't content entity if it contains that will be replaced.

```xml
<?xml version="1.0"?>
<!DOCTYPE employee SYSTEM "employee.dtd">
<employee>
  <firstname>vimal</firstname>
  <lastname>jaiswal</lastname>
  <email>vimal@javatpoint.com</email>
</employee>
```

In the above example, the employee element contains 3 more elements 'firstname', 'lastname', and 'email', so it parses further to get the data/text of firstname, lastname and email to give the value of employee as:
vimal jaiswal vimal@javatpoint.com

### XQuery

XQuery is a query language that is used to retrieve data from XML document.

### XML Namespace

- A namespace is a qualified name that is associated with the DTD/Schema location.
- A document may have duplicate elements and attributes. So, the namespace defines a way to compare duplicate elements and attribute names.

### SGML

- SGML is a vast and powerful generalized markup language that is used to define descriptions for the structure of several electronic documents.

### Can we use graphics in XML?

Yes, graphics can be stored in XML file by using XLink and XPointer. It supports graphics like GIF, JPG, TIFF, PNG, CGM, EPS, SVG.
