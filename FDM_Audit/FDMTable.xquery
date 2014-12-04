

let $csv := (/path/to/file/)
 
let $lines := tokenize($csv, '\n')
let $head := tokenize($lines[1], ',')
let $body := remove($lines, 1)
return

<TEI>
<teiHeader>{(/path/to/Template)}</teiHeader>
<text>
<body>
<head>{'https://raw.githubusercontent.com/HeardLibrary/corpus-baudelaire/master/fleurs-du-mal/FDM-TEI-HeaderTemplate.xml'}</head>
        {
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
        }
</body>
</text>
</TEI>