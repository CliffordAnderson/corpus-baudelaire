xquery version "3.1";

module namespace corpus = "http://library.vanderbilt.edu/baudelaire";

import module namespace view =  'http://www.library.vanderbilt.edu/baudelaire/view' at 'view.xqm';

declare namespace tei = "http://www.tei-c.org/ns/1.0";

declare variable $corpus:db := fn:collection("fleurs-du-mal"); 

declare 
    %rest:GET
    %rest:path("/search")
    %rest:query-param("q","{$term}")
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
  function corpus:search($term as xs:string*) as item()*
{(
  let $results := $corpus:db//tei:l[text() contains text {$term}]
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
    }) => corpus:format()
};

declare function corpus:format($results as element(p)*) as element(html)
{
  let $title := "Search Results"
  let $content :=
    element div {
      for $result in $results
       return 
         element p {
           "Line " || $result/@line || ": " ,
           $result/node(), 
           element a {
              attribute href {fn:replace(fn:replace($result/@base-uri, "fleurs-du-mal", "contents"), ".xml","") },
              " ... (read more)."
               }
         }  
    }
   return view:display-contents($title, $content)
};