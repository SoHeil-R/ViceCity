### SWEDISH ###

Du får använda detta scriptet men ladda inte upp det igen. Har du frågor så kan du mer än gärna ställa dem.
Jag kommer inte att fortsätta med detta scriptet.
Om du använder dig av en personmenu så kan du fixa en ny label och lägga in detta. Om du vill att man ska ha ett item för kunna bära så sätter du dessa två till false. Glöm inte att ladda upp SQLen för det även.

hasRope = false

hasUsedRope = false

table.insert(elements, {label = ('Lyft upp'), value = 'drag'})

if data.current.value == 'drag' then

  TriggerEvent('esx_barbie_lyftupp')

end

Om du vill använda engelska verisonen så byter du namn på detta i client.
"en-main.lua" till "main.lua"

Glöm inte bara skriva in i server.cfg "start esx_barbie_lyftupp"




### ENGLISH ###

You are able to use this script but do don't reupload it.
If you got any questions feel free to ask.
I won't continue with this script. If you are using a custommenu. You are able to add this to it. You can change so you need a rope to lift up people. Just change these to false. Don't forget to upload the SQL for the item.

hasRope = false

hasUsedRope = false

table.insert(elements, {label = ('Pick up'), value = 'drag'})

if data.current.value == 'drag' then

  TriggerEvent('esx_barbie_lyftupp')

end


If you are using english verison, just rename this in client.
"en-main.lua" to "main.lua"

Don't forget to add this in server.cfg "start esx_barbie_lyftupp"

### Picture ###
https://imgur.com/a/OcKF2gx


