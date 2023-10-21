using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

$data = @{
    "winter" = $("ski", "snowboard", "apresski")
    "summer" = $("surfing", "swimming", "summerbar")
}


$Request | convertto-json
$myCat = $Request.Params.cat
$myId = $Request.Params.id
$preferedSport = $Request.Body.preferedSport

$body = $data[$myCat]
if($myId){
    $body = $body[$myId]
}

# $body = "my prefered sport is $preferedSport"

# write-host "my prefered sport is $preferedSport"
#write-host "my cat is $myCat and id is $myId"

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
