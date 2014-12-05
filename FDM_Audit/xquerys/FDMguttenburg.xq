
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $doc := fn:doc("C:\GitHub\corpus-baudelaire\fleurs-du-mal\fleurs-du-mal.xml")
(:change path to doc on local machine
@edwarga: fn:doc("/Users/eddie/WORK/TEI/corpus-baudelaire/fleurs-du-mal/fleurs-du-mal.xml") 
or in github repository at url=https://raw.githubusercontent.com/HeardLibrary/corpus-baudelaire/master/fleurs-du-mal/fleurs-du-mal.xml
:)
return
$doc/tei:TEI/tei:text/tei:body//tei:div[@type]/tei:head

