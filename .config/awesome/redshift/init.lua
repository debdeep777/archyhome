--- Redshift for Awesome WM
-- author: Ryan Young <ryan .ry. young@gmail. com> (omit spaces)
--
-- https://github.com/YoRyan/awesome-redshift
--Modified for transition

-- standard libraries
local awful = require("awful")

-- variables
local redshift = {}
redshift.state = 1                         -- 1 for screen dimming, 0 for none

-- functions
redshift.dim = function()
    awful.util.spawn("notify-send 'Redshifting'")
    awful.util.spawn("redshift") 
-- pgrep -u $USER -x redshift || redshift
-- Ensures that only one instance of this program runs by this method, very clever trick
-- If screen fluctuates, redshift -o
    redshift.state = 1
end

redshift.undim = function()
    awful.util.spawn("notify-send 'Shifting back'")
    awful.util.spawn("pkill redshift")  -- If screen fluctuates, redshift -x
    redshift.state = 0
end

redshift.toggle = function()
    if redshift.state == 1
    then
        redshift.undim()
    else
        redshift.dim()
    end
end
redshift.init = function(initState)
    if initState == 1
    then
        redshift.dim()
    else
        redshift.undim()
    end
end

return redshift
