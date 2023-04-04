#!/usr/bin/expect -f

set timeout -1
set var1 [lindex $argv 0]
set var2 [lindex $argv 1]
set var3 [lindex $argv 2]
set var4 [lindex $argv 3]
set var5 [lindex $argv 4]
set var6 [lindex $argv 5]
set var7 [lindex $argv 6]
set var8 [lindex $argv 7]
set var9 [lindex $argv 8]
set var10 [lindex $argv 9]
set var11 [lindex $argv 10]
set var12 [lindex $argv 11]

spawn spim -file ./prj3.asm
expect ""
send -- "$var1\n"
expect ""
send -- "$var2\n"
expect ""
send -- "$var3\n"
expect ""
send -- "$var4\n"
expect ""
send -- "$var5\n"
expect ""
send -- "$var6\n"
expect ""
send -- "$var7\n"
expect ""
send -- "$var8\n"
expect ""
send -- "$var9\n"
expect ""
send -- "$var10\n"
expect ""
send -- "$var11\n"
expect ""
send -- "$var12\n"
expect eof
exit

