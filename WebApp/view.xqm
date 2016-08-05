module namespace view = 'http://www.library.vanderbilt.edu/baudelaire/view';
declare namespace tei = "http://www.tei-c.org/ns/1.0";

declare function view:format-poem($poem as element(tei:div)) as element(div)
{
    element div {view:passthru($poem)}
};

declare function view:dispatch($node as node()) as item()* {
    typeswitch($node)
        case text() return $node
        case comment() return $node
        case element(tei:title) return ()
        case element(tei:l) return element p { $node/text() }
        case element(tei:lg) return element div { (view:passthru($node), element br {}) }
        case element(tei:div) return element div { $node }
        default return view:passthru($node)
};  

declare function view:passthru($nodes as node()*) as item()* {
    for $node in $nodes/node() return view:dispatch($node)
};   


declare function view:format-div($content, $title) as element(div)
{
    view:format-div-with-title($content, $title)  
};

declare function view:format-div($content) as element(div)
{
    <div>
        {$content}
    </div>  
};

declare %private function view:format-div-with-title($content, $title) as element(div)
{
    <div>
        <h3>{$title}</h3>
        {$content}
    </div>  
};


declare function view:format-list($list as item()*) as element(ul) {
    <ul>
        {
        for $item in $list
        return element li 
            {
                $item
            }
        }
     </ul>
};

declare function view:format($results as element(p)*) as element(html)
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

declare function view:display-contents($title as xs:string?, $content as element()*) {
    <html>
        <head>
            <title>{$title}</title>
            <!-- Latest compiled and minified CSS -->
            <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"/>
            <!-- Optional theme -->
            <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css"/>
            <!-- Latest compiled and minified JavaScript -->
            <script src="//code.jquery.com/jquery-2.1.4.min.js"></script>
            <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
        </head>
        <body>
       <nav class="navbar navbar-inverse">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/">Corpus Baudelaire</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="/">Home</a></li>
            <li><a href="/about">About</a></li>
            <li><a href="/contents">Contents</a></li>
            <li><a href="/credits">Team</a></li>
          </ul>
          <form class="navbar-form navbar-left" role="search">
            <div class="form-group">
              <input type="text" name="q"  class="form-control" placeholder="Search"/>
            </div>
              <button type="submit" formaction="search" class="btn btn-default">Submit</button>
            </form>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

    <div class="container">

      <div class="starter-template">
        <h1>{$title}</h1>
        <div>{$content}</div>
      </div>
    </div>
        </body>
    </html>
};