

function Is-Numeric ($Value) {
    
    return $Value -match "^[\d\.]+$"

}

function Beep-multi ([int]$freq, [int] $millis, [int] $num){

    for ($i = 0; $i-lt $num; $i++){
        [console]::Beep($freq, $millis)
    }

}

function cursor-goto-fine ([int] $x_coordinate, [int] $y_coordinate){     
              
    [Console]::SetCursorPosition($x_coordinate, $y_coordinate);

}

$timestop = Read-Host("Input time in seconds")

if (Is-Numeric($timestop)) {

    $timestop = [math]::Round($timestop, 3)                    # convert string input into integer value

}


$timestop_string = '{0:N3}' -f $timestop

cls;
$time = [Diagnostics.Stopwatch]::StartNew()

$loop = 1
while ($loop -eq 1){
    
    Start-Sleep -Milliseconds 1

    $time_now = $time.elapsed.totalseconds
    if ($time_now -gt $timestop){
        $loop = 0
    }

    $time_now_round = [math]::Round($time_now, 3)
    $remain = $timestop - $time_now_round

    $percentage_remain = [math]::Round(100 * $remain / $timestop, 2)
    $percentage_remain_string = '{0:N2}' -f $percentage_remain

    $time_now_round_string = '{0:N3}' -f $time_now_round
    $remain_string = '{0:N3}' -f $remain
    cursor-goto-fine(2)(2)
    [console]::Write("$time_now_round_string of $timestop_string seconds          `nTime remaining: $remain_string seconds ($percentage_remain_string%)            `n")

}

cls;
[console]::Write("Time's up! Time elapsed: $timestop_string seconds.`n ctrl + C to close.")
Beep-multi (2000)(500)(30)

start-sleep 60
