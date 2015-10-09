module namespace model = 'http://www.library.vanderbilt.edu/baudelaire/model';
import module namespace view =  'http://www.library.vanderbilt.edu/baudelaire/view' at 'view.xqm';
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $model:collection := fn:collection("fleurs-du-mal");

declare function model:get-poem-by-idno($idno) {
    for $doc in $model:collection
    where $doc//tei:idno = $idno
    let $poem := $doc//tei:text/tei:body/tei:div
    return view:format-poem($poem)
};

declare function model:get-title-by-idno($idno) {
    for $doc in $model:collection
    where $doc//tei:idno = $idno
    return fn:data($doc//tei:titleStmt/tei:title)
};


declare function model:list-names() {
    let $names := $model:collection//tei:respStmt/tei:name/text()
    for $name in fn:distinct-values($names)
    order by fn:replace($name, ".* (.*$)", "$1")
    return $name
};

declare function model:credits() as element(div) {
    let $title := "Key Contributors"
    let $list :=
        for $name in model:list-names()
        return $name
    return 
        $list
        => view:format-list() 
        => view:format-div($title)
};

declare function model:toc() as element(div) {
    let $list :=
        for $doc in $model:collection
        let $title := fn:data($doc//tei:titleStmt/tei:title)
        let $idno := $doc//tei:idno
        return 
            element a {
                attribute href {'/contents/' || $idno},
                $title
                }
    return element div {view:format-list($list)}
};

declare function model:search($term as xs:string*) as item()*
{(
  let $results := $model:collection//tei:l[text() contains text {$term}]
  for $result in $results
  let $score := ft:score($result[text() contains text {$term}])
  let $snippet := ft:extract($result/text()[. contains text {$term}], "b")
  let $base-uri := fn:base-uri($result)
  let $line := $result/@n
  order by $score descending
  where $base-uri != "fleurs-du-mal/fleurs-du-mal.xml"
  return 
    element p {
      attribute score {$score},
      attribute base-uri {$base-uri},
      attribute line {$line},
      $snippet
    })
};