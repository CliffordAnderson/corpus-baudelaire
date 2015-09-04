xquery version "3.1";

module namespace corpus = "http://library.vanderbilt.edu/baudelaire";

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
  <html lang="en">
  <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Corpus Baudelaire - Search Results</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
 </head>
  <body>
    <div class="container-fluid">
 
    <h1>Search Results</h1>
    
    {for $result in $results
     return 
       element p {
         "Line " || $result/@line || ": " ,
         $result/node(), 
         element a {
            attribute href {$result/@base-uri},
            "...(read more)."
             }
           } 
  } 
   </div>
  </body>
</html> 
};