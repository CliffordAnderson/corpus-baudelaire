
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $docs := fn:collection("/Users/eddie/WORK/TEI/corpus-baudelaire")
(:change path to collection on local machine
:)

let $titles := $docs/tei:TEI/tei:text/tei:body/tei:div/tei:head/tei:title[fn:not(@type="sub")]/text()

for $each in $titles
return
fn:string-join($titles, "'&#xa;'")
