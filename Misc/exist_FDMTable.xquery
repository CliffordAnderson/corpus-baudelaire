xquery version "3.0";

let $csv := file:read("C:\GitHub\corpus-baudelaire\Misc\EditionsTable.csv")

let $lines := tokenize($csv, '\n')
let $head := tokenize($lines[1], ',')
let $head := ($head[position()=(1 to last()-1)], substring($head[position()= last()], 1, last()-5))
let $body := remove($lines, 1)
return
  
            for $line in $body
            let $fields := tokenize($line, ',')

            return
                <poem>
                    {
                        for $key at $pos in $head
                        let $value := $fields[$pos]
                        return
                            element { $key } { $value }
                    }
                </poem>
        
