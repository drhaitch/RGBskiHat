D0=16:D1=5:D2=4:D3=0:D4=2:D5=14:D6=12:D7=13:D8=15:D9=3:D10=1
cls
wlog "hello"
dim s$(6)
neo.setup D1,287
gosub setcolors


dim p(8)

p(0)=0:p(1)=45:p(2)=90:p(3)=134:p(4)=179:p(5)=224:p(6)=269:p(7)=286
'line 0 starts at 0 ,48 ,95,142,188,233,276
neo.pixel 0,255
neo.pixel 45,255
neo.pixel 90,255
neo.pixel 134,255
neo.pixel 179,255
neo.pixel 224,255
neo.pixel 269,255
neo.pixel 286,255,0,0


for q = 0 to 7
neo.pixel p(q),0,0,255
next q

gosub movingbar
'test eyes
gosub doeyes


'test scroll text
gosub settext
for g = 0 to 104
gg = (g mod 54)+1
for ii = 0 to 5
if mid$(s$(ii),gg,1) = "1" then
neo.pixel p(ii+1)-1,col(g mod 85),1
end if
next ii
gosub scrolltext
next g

'test scroll text 2
wlog "scroll text red energy"
gosub settext2
for g = 0 to 80
gg = (g mod 59)+1
for ii = 0 to 5
if mid$(s$(ii),gg,1) = "1" then
neo.pixel p(ii+1)-1,col(g mod 85),1
end if
next ii
gosub scrolltext
next g



'moving bar

for g = 0 to 40
for t = 3 to 44
for i = 0 to 6
'for tt = 0 to 4
neo.pixel p(i)+t,col((t+g)mod 85),1
neo.pixel p(i)+t-3,0,0,0,1
'next tt
next i
pause 10
neo.pixel 0,neo.getpixel(0)
next t
next g


'redblue lines
for r = 0 to 5
if (r mod 5) = 1 then
neo.pixel 0,2,255,255,1
end if
gosub scrollup
next r

for b = 0 to 150
neo.strip 0,299,0
z = (b mod 7)
neo.strip p(z),p(z+1),255,0,0,1
z = ((b+3) mod 7)
neo.strip p(z),p(z+1),0,0,255
pause 120
next b


end
scrollup:
for t = 299 to 1 step -1
neo.pixel t,neo.getpixel(t-1),1
next t
neo.pixel(0),0
return

doeyes:
'test eyes
eyecolor = col(rnd(85))
for de = 0 to 20
px=rnd(4): py=rnd(3)
gosub draweyes
gosub drawpupils
pause (700 + rnd(5)*100)
if rnd(3) = 0 then gosub blink
next de
neo.strip 0,260,0,0,0,1
return

drawpupils:
neo.pixel 17+px+p(py+1),0,0,0,1
neo.pixel 18+px+p(py+1),0,0,0,1
neo.pixel 17+px+p(py+2),0,0,0,1
neo.pixel 18+px+p(py+2),0,0,0,1
neo.pixel 24+px+p(py+1),0,0,0,1
neo.pixel 25+px+p(py+1),0,0,0,1
neo.pixel 24+px+p(py+2),0,0,0,1
neo.pixel 25+px+p(py+2),0,0,0
return


draweyes:
gosub seteyes
for f = 1 to 12
for ii = 0 to 5
if mid$(s$(ii),f,1) = "1" then
neo.pixel p(ii)+f+16,eyecolor,1
end if
next ii
next f
return

blink:
cls
wlog "Blink"
'already will have eye data
for bclose = 5 to 0 step -1
neo.strip 0,269,0,0,0,1
for f = 1 to 12
for ii = 0 to bclose
if mid$(s$(ii),f,1) = "1" then
neo.pixel p(ii)+f+16,eyecolor,1
end if
next ii
next f
neo.pixel 0,neo.getpixel(0)
next bclose
for bclose = 1 to 5
for f = 1 to 12
for ii = 0 to bclose
if mid$(s$(ii),f,1) = "1" then
neo.pixel p(ii)+f+16,eyecolor,1
end if
next ii
next f
neo.pixel 0,neo.getpixel(0)
next bclose

return

movingbar:
'moving bar
for gg = 0 to 10
for g = 0 to 85
neo.strip 0,286,col(g)
pause 10
next g
next gg
return

setText:
s$(5) ="111000000000000000000000011100000000000000000000000000"
s$(4) ="100101001110011100110000100010000001111011110011000000"
s$(3) ="100100010000100001001000100010100101000010000100100000"
s$(2) ="0100101001100100001001000101010100101110011100100100000"
s$(1) ="100101000010100001001000100100100101000010000100100000"
s$(0) ="111001011100011100110000011110011001111011110100100000"
return

settext2:
s$(5) ="111000111100111000000111100100100111100111000011000100100000"
s$(4) ="100100100000100100000100000110100100000100100100000100100000"
s$(3) ="100100111000100100000111000111100111000100100100000100100000"
s$(2) ="0111000100000100100000100000101100100000111000101100011100000"
s$(1) ="101000100000100100000100000100100100000101000100100000100000"
s$(0) ="100100111100111000000111100100100111100100100011000111000000"
return

seteyes:
s$(5) ="011100001110000000000000000000000000000000000000000000000000"
s$(4) ="111110011111000000000000000000000000000000000000000000000000"
s$(3) ="111110011111000000000000000000000000000000000000000000000000"
s$(2) ="111110011111000000000000000000000000000000000000000000000000"
s$(1) ="111110011111000000000000000000000000000000000000000000000000"
s$(0) ="011100001110000000000000000000000000000000000000000000000000"
return

setcolors:
dim col(86)
col(0) = neo.rgb(63,0,0)
col(1) = neo.rgb(63,4,0)
col(2) = neo.rgb(63,8,0)
col(3) = neo.rgb(63,13,0)
col(4) = neo.rgb(63,17,0)
col(5) = neo.rgb(63,22,0)
col(6) = neo.rgb(63,26,0)
col(7) = neo.rgb(63,31,0)
col(8) = neo.rgb(63,35,0)
col(9) = neo.rgb(63,40,0)
col(10) = neo.rgb(63,44,0)
col(11) = neo.rgb(63,48,0)
col(12) = neo.rgb(63,53,0)
col(13) = neo.rgb(63,57,0)
col(14) = neo.rgb(63,62,0)
col(15) = neo.rgb(60,63,0)
col(16) = neo.rgb(56,63,0)
col(17) = neo.rgb(51,63,0)
col(18) = neo.rgb(47,63,0)
col(19) = neo.rgb(42,63,0)
col(20) = neo.rgb(38,63,0)
col(21) = neo.rgb(34,63,0)
col(22) = neo.rgb(29,63,0)
col(23) = neo.rgb(25,63,0)
col(24) = neo.rgb(20,63,0)
col(25) = neo.rgb(16,63,0)
col(26) = neo.rgb(11,63,0)
col(27) = neo.rgb(7,63,0)
col(28) = neo.rgb(2,63,0)
col(29) = neo.rgb(0,63,1)
col(30) = neo.rgb(0,63,5)
col(31) = neo.rgb(0,63,10)
col(32) = neo.rgb(0,63,14)
col(33) = neo.rgb(0,63,19)
col(34) = neo.rgb(0,63,23)
col(35) = neo.rgb(0,63,28)
col(36) = neo.rgb(0,63,32)
col(37) = neo.rgb(0,63,37)
col(38) = neo.rgb(0,63,41)
col(39) = neo.rgb(0,63,45)
col(40) = neo.rgb(0,63,50)
col(41) = neo.rgb(0,63,54)
col(42) = neo.rgb(0,63,59)
col(43) = neo.rgb(0,63,63)
col(44) = neo.rgb(0,59,63)
col(45) = neo.rgb(0,54,63)
col(46) = neo.rgb(0,50,63)
col(47) = neo.rgb(0,45,63)
col(48) = neo.rgb(0,41,63)
col(49) = neo.rgb(0,37,63)
col(50) = neo.rgb(0,32,63)
col(51) = neo.rgb(0,28,63)
col(52) = neo.rgb(0,23,63)
col(53) = neo.rgb(0,19,63)
col(54) = neo.rgb(0,14,63)
col(55) = neo.rgb(0,10,63)
col(56) = neo.rgb(0,5,63)
col(57) = neo.rgb(0,1,63)
col(58) = neo.rgb(2,0,63)
col(59) = neo.rgb(7,0,63)
col(60) = neo.rgb(11,0,63)
col(61) = neo.rgb(16,0,63)
col(62) = neo.rgb(20,0,63)
col(63) = neo.rgb(25,0,63)
col(64) = neo.rgb(29,0,63)
col(65) = neo.rgb(34,0,63)
col(66) = neo.rgb(38,0,63)
col(67) = neo.rgb(42,0,63)
col(68) = neo.rgb(47,0,63)
col(69) = neo.rgb(51,0,63)
col(70) = neo.rgb(56,0,63)
col(71) = neo.rgb(60,0,63)
col(72) = neo.rgb(63,0,62)
col(73) = neo.rgb(63,0,57)
col(74) = neo.rgb(63,0,53)
col(75) = neo.rgb(63,0,48)
col(76) = neo.rgb(63,0,44)
col(77) = neo.rgb(63,0,40)
col(78) = neo.rgb(63,0,35)
col(79) = neo.rgb(63,0,31)
col(80) = neo.rgb(63,0,26)
col(81) = neo.rgb(63,0,22)
col(82) = neo.rgb(63,0,17)
col(83) = neo.rgb(63,0,13)
col(84) = neo.rgb(63,0,8)
col(85) = neo.rgb(63,0,4)

return

scrolltext:
for zz= 0 to 5 
for zp = p(zz)+5 to p(zz+1)-1
neo.pixel zp,neo.getpixel(zp+1),1
next zp
neo.pixel p(zz+1)-1,0,0,0,1
next zz
neo.pixel 0,neo.getpixel(0)
return
  

