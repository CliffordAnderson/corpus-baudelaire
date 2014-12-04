
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $docs := fn:collection("/Users/eddie/WORK/TEI/corpus-baudelaire")
(:change path to collection on local machine
:)

let $idno := $docs/tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno/text()


return
fn:string-join($idno, "'&#xa;'")
