
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $docs := fn:collection("/Users/eddie/WORK/TEI/corpus-baudelaire/fleurs-du-mal")
(:change path to doc on local machine
@edwarga: fn:collection("/Users/eddie/WORK/TEI/corpus-baudelaire/fleurs-du-mal") 
or in github repository at url=https://raw.githubusercontent.com/HeardLibrary/corpus-baudelaire/master/fleurs-du-mal
:)
return
$docs

