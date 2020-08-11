#!/bin/bash

touch $1

cat <<EOT > $1
<!doctype html>
<html lang="en">
 <head>
   <!-- Required meta tags -->
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 
   <!-- Bootstrap CSS -->
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
   <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
 
   <title>Randoop Result</title>
 </head>
 <body>
   <h1>Randoop Result</h1>
   <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
       <li class="nav-item" role="presentation">
           <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">ver1 Error Test</a>
       </li>
       <li class="nav-item" role="presentation">
           <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">ver2 Error Test</a>
       </li>
       <li class="nav-item" role="presentation">
           <a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">Regression Test</a>
       </li>
   </ul>
   <div class="tab-content" id="pills-tabContent">
EOT

#first column
cat <<EOT >> $1
<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
EOT
python3 randoop2json.py "$2" >> $1
cat <<EOT >> $1
</div>
EOT

#second column
cat <<EOT >> $1
<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
EOT
python3 randoop2json.py "$3" >> $1
cat <<EOT >> $1
</div>
EOT

#third column
cat <<EOT >> $1
<div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
EOT
python3 randoop2json.py "$4" >> $1
cat <<EOT >> $1
</div>
EOT

cat <<EOT >> $1
</div>
 </body>
</html>

EOT
