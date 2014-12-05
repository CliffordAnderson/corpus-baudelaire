
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $doc := fn:doc("/Users/eddie/WORK/TEI/corpus-baudelaire/FDM_Audit/GuttenburgpoemsWithMarkup.xml")
(:change path to doc on local machine
@edwarga: fn:doc("/Users/eddie/WORK/TEI/corpus-baudelaire/fleurs-du-mal/fleurs-du-mal.xml") 
or in github repository at url=https://raw.githubusercontent.com/HeardLibrary/corpus-baudelaire/master/fleurs-du-mal/fleurs-du-mal.xml
:)

let $poems := $doc/tei:TEI/tei:text/tei:body/tei:div[tei:head/tei:title]


for $each in $poems
let $item :=
  
<TEI xmlns="http://www.tei-c.org/ns/1.0"><teiHeader>{$doc/tei:TEI/tei:teiHeader}</teiHeader><text><body>{$each}</body></text></TEI>

let $title := $each/tei:head/tei:title
let $path := string-join(("/Users/eddie/WORK/TEI/corpus-baudelaire/FDM_Audit/GuttenburgMarkup/", $title, ".xml"), "")

return
file:write($path, $item)