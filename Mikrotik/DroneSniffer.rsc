:local channel6Weight 60;
:local channelItems ({"2412";"2417";"2422";"2427";"2432";"2437";"2442";"2447";"2452";"2457";"2462";"2467"});
:local channelWeights ({((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); chan6=$channel6Weight; ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11); ((100-$channel6Weight)/11);((100-$channel6Weight)/11);});


:local totalWeight 0;
:foreach weight in=$channelWeights do={
  :set totalWeight ($totalWeight + $weight);
}

:local randNum [:rndnum from=1 to=$totalWeight];

:local selectedValue "Unknown";
:local currentThreshold 0;

:for i from=0 to=([:len $channelItems] - 1) do={
  :local weight ($channelWeights->$i);
  :set currentThreshold ($currentThreshold + $weight);
  
  :if ($randNum < $currentThreshold) do={
    :set selectedValue ($channelItems->$i);
    :local finalChance (($weight * 100) / $totalWeight);
    
    # Output the result
    :log info "Rolled: $selectedValue (Weight: $weight, Probability: $finalChance %)";
    :break;
  }
}


# Check for newer wifi (wifiwave2) interfaces configuration.mode,
:foreach i in=[/interface wifi find] do={
    :local ifaceName [/interface wifi get $i name];
    :local ifaceConfigMode [/interface wifi get $i configuration.mode];
    :local ifaceConfigMode [/interface wifi get $i configuration.manager];
    :local ifaceConfigMode [/interface wifi get $i channel.frequency];


    :log info [/interface wifi get $i name];
    :log info [/interface wifi get $i configuration.mode];
    :log info [/interface wifi get $i configuration.manager];
    :log info [/interface wifi get $i channel.frequency];
    :log info [/interface wifi get $i about];
}


/interface/wifi sniffer wifi1 duration=0 stream-rate=4294967295 stream-address=192.168.10.32

:execute {/interface/wifi sniffer wifi1 duration=0 stream-rate=4294967295 stream-address=192.168.10.32}
 /system/script/job/print detail 
 /system/script/job/remove 2