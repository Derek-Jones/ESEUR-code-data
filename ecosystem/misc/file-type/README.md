UK Web Domain Dataset (1996-2010) Format Profile
================================================

As well as collecting the MIME type delivered by the server, we have also run two format identification tools over the content of each HTTP 200 OK response. These tools were Apache Tika and DROID. All three MIME types are collected, along with the year the resource was crawled. These four pieces of information are treated as a 'key' for the resource, and the number of resources with that key are counted up, over the entire dataset. The result is output as tab separated data. For full details see, the Nanite codebase, tag v.0.1.1 was used to create this dataset.

For example, this line:
<pre>
application/x-csv       text/plain      application/octet-stream        2009    1
</pre>
means that, of all the resources crawled in 2009, there was one item that the server declared to be CSV, but which Tika determined to be plain text, and which DROID could not identify at all.

The 'cleaned' version is a concatenation of all the results for each batch of the total collection. There were some minor issues with the data, such as the presence of NULL characters, and crawl years that make no sense (9101, 1936, 2036, 1980). The 'cleaned' version has had these suspect characters and lines removed.

Extended MIME Types
-------------------

To bridge between common MIME type usage and the more formalised format definitions in, e.g. PRONOM, we have produced a convention for extended MIME types that is in accord with the relevant RFCs but allows these identifiers to be mapped.

At heart, we introduce three extended forms:

* For formats with MIME types, we add a version parameter that can be mapped to a PRONOM ID. e.g. instead of just 'application/pdf', we can use 'application/pdf; version=1.4', and map this to PUID fmt/18.
* For formats with no MIME type, but with a PRONOM ID, we can mind non-standard MIME types that bridge the gap, such as: 'application/x-puid-fmt-44'
* For formats with neither a MIME Type or a PUID, we can usually fall back on file extensions, e.g. 'application/x-ext-ini' for a '.ini' file.

To help us cope in those cases where a suitable PRONOM record does not yet exist, we need to be able to link a format back to the software that created it. To this end, we also seek to formalise extended MIME Type parameters that can be used to capture the encoding software. This is complicated by the fact that different formats currently encode this information in different and often confusing ways. For example, it is not always clear if a format is documenting the software that created an object, or the software that an object is being encoded for - i.e. when you take a 'Word 14' DOCX and export as 'Word 97-2004' Doc, which software identity is recorded where?

At the most basic, many formats have some 'software' field that we can map to a 'software=XXX' parameter. Notably, PDF documents both the 'Producer' (e.g. Adobe Distiller X) and the 'Creator' meaning the creating application of the source document (e.g. Open Office or Microsoft Word). In other cases, this kind of information is stored in comment fields, like 'Text TextEntry: keyword=Software, value=ImageMagick, encoding=ISO-8859-1, compression=none' in the case of PNG.

It may be possible to collect and normalise these formulations, but for now, we seek to simply document the conflict. Thus, for a particular PDF, we may have an extended MIME Type like this:
<pre>
	application/pdf; version=1.4; creator=Writer; producer="OpenOffice.org 3.2"
</pre>
whereas for a ODF document, we have forms like this:
<pre>
	application/vnd.oasis.opendocument.text; software="OpenOffice.org/3.2$Win32 OpenOffice.org_project/320m12$Build-9483"
</pre>

Although this is rather clumsy, collecting this initial data will help us find a way forward. Finding new mappings, like whether 'pdf:producer' can be mapped to 'software', can be explored using this data and decided upon later.

Tools
-----
Some example scripts for processing this data can be found [here](../../tools)

License
-------
<p xmlns:dct="http://purl.org/dc/terms/">
  <a rel="license"
     href="http://creativecommons.org/publicdomain/zero/1.0/">
    <img src="http://i.creativecommons.org/p/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" />
  </a>
  <br />
  To the extent possible under law,
  <a rel="dct:publisher"
     href="http://data.webarchive.org.uk/opendata/ukwa.ds.2/">
    <span property="dct:title">The Project Partners</span></a>
  have waived all copyright and related or neighboring rights to
  <span property="dct:title">The UK Web Domain Dataset (1996-2010) Format Profile</span>.
</p>

Citing this dataset
-------------------
If you do wish to cite this dataset, please this DOI: [**10.5259/ukwa.ds.2/fmt/1**](http://dx.doi.org/10.5259/ukwa.ds.2/fmt/1).
