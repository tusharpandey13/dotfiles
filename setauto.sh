 #!/bin/bash
  
  file=$1
  
  if [[ "$file" =~ 'power' ]]
  then
        echo "$file"
        echo "auto" > "$file"
       echo "PCI control has been set to auto."
 fi
