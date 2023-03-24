[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
#import mouse_event
Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern void mouse_event(int flags, int dx, int dy, int cButtons, int info);' -Name U32 -Namespace W;
<#
Automatic mouse mover and clicker by koh-gt
25 Mar 2023

README!
set $test to 1 and find the x and y coordinates of the Vote button, 
choose energy button, choose 8 energy button and the buy button.

ADJUST PARAMETERS ACCORDINGLY
Set $test to 0
USE AND MODIFY SCRIPT AT OWN RISK
#>
# PARAMETERS
$loop = 1
$test = 0
$x_vote, $y_vote = 3080, 270
$x_choose_e, $y_choose_e = 2584, 742
$x_choose_e8, $y_choose_e8 = 2553, 1007
$x_buy, $y_buy = 2577, 880
#
[console]::Write("`n Press X to exit.`n")
# MAIN FUNCTIONS
Function Move-Mouse {
`	Param (
        [int]$X, [int]$y
    )
    Process {
        Add-Type -AssemblyName System.Windows.Forms
        $screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
        $screen | Get-Member -MemberType Property
        $screen.Width = $X
        $screen.Height = $y
        [Windows.Forms.Cursor]::Position = "$($screen.Width),$($screen.Height)"
    }
}
Function Click-mouse {
    Process {
        $SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
        $SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);
        }
}
# auto voter
# starts at 10 energy
if ($test -eq 0){
    Move-Mouse -x $x_vote -y $y_vote # vote
    [W.U32]::mouse_event(6,0,0,0,0); start-sleep -Milliseconds 500
    }
$times = 0
#MAIN LOOP
while ($loop -eq 1) {
    if ([console]::KeyAvailable) { 
        $x = [System.Console]::ReadKey() 
        switch ($x.key)
        {
            X {$loop = 0}
        }
    }
    if ($test -eq 0){
        Move-Mouse -x $x_vote -y $y_vote # vote
        [W.U32]::mouse_event(6,0,0,0,0);; start-sleep -Milliseconds 800
        [W.U32]::mouse_event(6,0,0,0,0);; start-sleep -Milliseconds 800
        [W.U32]::mouse_event(6,0,0,0,0);; start-sleep -Milliseconds 800
        [W.U32]::mouse_event(6,0,0,0,0);; start-sleep -Milliseconds 800
        [W.U32]::mouse_event(6,0,0,0,0);; start-sleep -Milliseconds 800
        Move-Mouse -x $x_choose_e -y $y_choose_e #choose energy
        [W.U32]::mouse_event(6,0,0,0,0);; start-sleep -Milliseconds 500
        Move-Mouse -x $x_choose_e8 -y $y_choose_e8 #choose 8 energy
        [W.U32]::mouse_event(6,0,0,0,0);; start-sleep -Milliseconds 500
        Move-Mouse -x $x_buy -y $y_buy # Buy
        [W.U32]::mouse_event(6,0,0,0,0);; start-sleep -Milliseconds 1500
    }
    if ($test -eq 1) {
        $x = [System.Windows.Forms.Cursor]::Position.x
        $y = [System.Windows.Forms.Cursor]::Position.y
        [console]::Write("$x x $y y `n")
        start-sleep -Milliseconds 500
    } 
    $times = $times + 1
    if ($times -eq 100){
        [console]::Write("5 seconds pause for closing`n")
        start-sleep -Seconds 5
    }
    [console]::Write("Loop $times of 100`n")

}

