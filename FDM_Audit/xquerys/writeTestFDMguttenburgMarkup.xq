
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $doc := fn:doc("/Users/eddie/WORK/TEI/corpus-baudelaire/FDM_Audit/GuttenburgpoemsWithMarkup.xml")
(:change path to doc on local machine
@edwarga: fn:doc("/Users/eddie/WORK/TEI/corpus-baudelaire/fleurs-du-mal/fleurs-du-mal.xml") 
or in github repository at url=https://raw.githubusercontent.com/HeardLibrary/corpus-baudelaire/master/fleurs-du-mal/fleurs-du-mal.xml
:)

let $poems := $doc/tei:TEI/tei:text/tei:body/tei:div[tei:head/tei:title]


for $each in $poems
let $item :=
  
<TEI><teiHeader xmlns="http://www.tei-c.org/ns/1.0">{$doc/tei:TEI/tei:teiHeader}</teiHeader><text><body>{$each}</body></text></TEI>
let $count := (1 to 79)
for $num in $count
let $path := string-join(("/Users/eddie/WORK/TEI/corpus-baudelaire/FDM_Audit/writeTest/gtnbrgMarkup", string($num), ".xml"), "")


return
file:write($path, $item)