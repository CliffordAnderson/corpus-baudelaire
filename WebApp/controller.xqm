module namespace controller = 'http://www.library.vanderbilt.edu/baudelaire/controller';
import module namespace view =  'http://www.library.vanderbilt.edu/baudelaire/view' at 'view.xqm';
import module namespace model =  'http://www.library.vanderbilt.edu/baudelaire/model' at 'model.xqm';

declare 
    %rest:path("/") 
    %rest:GET
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function controller:contents() {
          view:display-contents("Corpus Baudelaire", <p>Hello!</p>)
        };

declare 
    %rest:path("/about") 
    %rest:GET
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function controller:about() {
          let $title := "About Corpus Baudelaire"
          let $content := element p {"Here is some information about the corpus baudelaire project."}
          return view:display-contents($title, $content)
        };

declare 
    %rest:path("/credits") 
    %rest:GET
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function controller:credits() {
          let $title := "Contributors to Corpus Baudelaire"
          let $content := model:credits()
          return view:display-contents($title, $content)
        };
 
 declare 
    %rest:path("/contents") 
    %rest:GET
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function controller:toc() {
          let $title := "Contents of Corpus Baudelaire"
          let $content := model:toc()
          return view:display-contents($title, $content)
        };
        
 declare 
    %rest:path("/contents/{$idno}") 
    %rest:GET
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function controller:idno($idno) {
          let $title := model:get-title-by-idno($idno)
          let $content := model:get-poem-by-idno($idno)
          return view:display-contents($title, $content)
        };
  
  declare 
    %rest:GET
    %rest:path("/search")
    %rest:query-param("q","{$term}")
    %output:method("html")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
  function controller:search($term as xs:string*) as item()*{
    model:search($term) => view:format()
  };
  
  declare
    %rest:path("/error404")
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function controller:error404() {
          let $title := "Corpus Baudelaire"
          let $content := element p {"Error! This page does not exist!"}
          return view:display-contents($title, $content)
        };
        
 