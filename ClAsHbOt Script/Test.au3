Func TestMyStuff()
   Local $MyGold = Number(ScrapeFuzzyText($gSmallCharacterMaps, $rMyGoldTextBox, $gSmallCharMapsMaxWidth, $eScrapeDropSpaces))
   DebugWrite("My Gold: " & $MyGold)
   Local $MyElix = Number(ScrapeFuzzyText($gSmallCharacterMaps, $rMyElixTextBox, $gSmallCharMapsMaxWidth, $eScrapeDropSpaces))
   DebugWrite("My Elix: " & $MyElix)
   Local $MyDark = 0
   If IsTextBoxPresent($rMyGemsTextBoxWithDE) = True Then
      $MyDark = Number(ScrapeFuzzyText($gSmallCharacterMaps, $rMyDarkTextBox, $gSmallCharMapsMaxWidth, $eScrapeDropSpaces))
   EndIf
   DebugWrite("My Dark: " & $MyDark)
   Local $MyGems = 0
   If IsTextBoxPresent($rMyGemsTextBoxNoDE) = True Then
      $MyGems = Number(ScrapeFuzzyText($gSmallCharacterMaps, $rMyGemsTextBoxNoDE, $gSmallCharMapsMaxWidth, $eScrapeDropSpaces))
   Else
      $MyGems = Number(ScrapeFuzzyText($gSmallCharacterMaps, $rMyGemsTextBoxWithDE, $gSmallCharMapsMaxWidth, $eScrapeDropSpaces))
   EndIf
   DebugWrite("My Gems: " & $MyGems)
   Local $MyCups = Number(ScrapeFuzzyText($gSmallCharacterMaps, $rMyCupsTextBox, $gSmallCharMapsMaxWidth, $eScrapeDropSpaces))
   DebugWrite("My Cups: " & $MyCups)
EndFunc

Func TestRaidLoot()
   Local $gold = Number(ScrapeFuzzyText($gRaidLootCharMaps, $rGoldTextBox, $gRaidLootCharMapsMaxWidth, $eScrapeDropSpaces))
   DebugWrite("Gold: " & $gold)
   Local $elix = Number(ScrapeFuzzyText($gRaidLootCharMaps, $rElixTextBox, $gRaidLootCharMapsMaxWidth, $eScrapeDropSpaces))
   DebugWrite("Elix: " & $elix)
   Local $dark = 0
   Local $cups = 0
   If IsTextBoxPresent($rDarkTextBox)=False Then
      $cups = Number(ScrapeFuzzyText($gRaidLootCharMaps, $rCupsTextBoxNoDE, $gRaidLootCharMapsMaxWidth, $eScrapeDropSpaces))
   Else
      $dark = Number(ScrapeFuzzyText($gRaidLootCharMaps, $rDarkTextBox, $gRaidLootCharMapsMaxWidth, $eScrapeDropSpaces))
      $cups = Number(ScrapeFuzzyText($gRaidLootCharMaps, $rCupsTextBoxWithDE, $gRaidLootCharMapsMaxWidth, $eScrapeDropSpaces))
   EndIf
   DebugWrite("Dark: " & $dark)
   DebugWrite("Cups: " & $cups)
   Local $deadBase = IsColorPresent($rDeadBaseIndicatorColor)
   DebugWrite("Dead: " & $deadBase)
   Local $location, $top, $left
   Local $townHall = GetTownHallLevel(False, $location, $left, $top)
   DebugWrite("TH: " & $townHall)
EndFunc

Func TestEndBattleLoot()
   Local $goldWin = ScrapeFuzzyText($gBattleEndWinningsCharacterMaps, $rEndBattleGoldTextBox, $gBattleEndWinningsCharMapsMaxWidth, $eScrapeDropSpaces)
   Local $elixWin = ScrapeFuzzyText($gBattleEndWinningsCharacterMaps, $rEndBattleElixTextBox, $gBattleEndWinningsCharMapsMaxWidth, $eScrapeDropSpaces)
   Local $darkWin = IsTextBoxPresent($rEndBattleDarkTextBox) ? ScrapeFuzzyText($gBattleEndWinningsCharacterMaps, $rEndBattleDarkTextBox, $gBattleEndWinningsCharMapsMaxWidth, $eScrapeDropSpaces) : 0
   Local $cupsWin = IsTextBoxPresent($rEndBattleCupsWithDETextBox) ? _
					ScrapeFuzzyText($gBattleEndWinningsCharacterMaps, $rEndBattleCupsWithDETextBox, $gBattleEndWinningsCharMapsMaxWidth, $eScrapeDropSpaces) : _
					ScrapeFuzzyText($gBattleEndWinningsCharacterMaps, $rEndBattleCupsNoDETextBox, $gBattleEndWinningsCharMapsMaxWidth, $eScrapeDropSpaces)
   DebugWrite("Gold: " & $goldWin)
   DebugWrite("Elix: " & $elixWin)
   DebugWrite("Dark: " & $darkWin)
   DebugWrite("Cups: " & $cupsWin)
EndFunc

Func TestEndBattleBonus()
   Local $goldBonus = 0
   Local $elixBonus = 0
   Local $darkBonus = 0
   If IsTextBoxPresent($rEndBattleBonusGoldTextBox) Or _
	  IsTextBoxPresent($rEndBattleBonusElixTextBox) Or _
	  IsTextBoxPresent($rEndBattleBonusDarkTextBox) Then

	  $goldBonus = ScrapeFuzzyText($gBattleEndBonusCharacterMaps, $rEndBattleBonusGoldTextBox, $gBattleEndBonusCharMapsMaxWidth, $eScrapeDropSpaces)
	  $goldBonus = StringLeft($goldBonus, 1) = "+" ? StringMid($goldBonus, 2) : 0
	  $elixBonus = ScrapeFuzzyText($gBattleEndBonusCharacterMaps, $rEndBattleBonusElixTextBox, $gBattleEndBonusCharMapsMaxWidth, $eScrapeDropSpaces)
	  $elixBonus = StringLeft($elixBonus, 1) = "+" ? StringMid($elixBonus, 2) : 0
	  $darkBonus = ScrapeFuzzyText($gBattleEndBonusCharacterMaps, $rEndBattleBonusDarkTextBox, $gBattleEndBonusCharMapsMaxWidth, $eScrapeDropSpaces)
	  $darkBonus = StringLeft($darkBonus, 1) = "+" ? StringMid($darkBonus, 2) : 0
	  DebugWrite("Bonus this match: " & $goldBonus & " / " & $elixBonus & " / " & $darkBonus)
   EndIf
EndFunc

Func TestStorage()
   GrabFrameToFile("StorageUsageFrame.bmp", 261, 200, 761, 550)
   Local $x, $y, $conf, $matchIndex
   Local $usageAdj = 10

   ScanFrameForBestBMP("StorageUsageFrame.bmp", $GoldStorageBMPs, $gConfidenceStorages, $matchIndex, $conf, $x, $y)
   DebugWrite("Gold Match Index: " & $matchIndex)
   If $matchIndex <> -1 Then
	  Local $s = $GoldStorageBMPs[$matchIndex]
	  Local $level = Number(StringMid($s, StringInStr($s, "GoldStorageL")+12, 2))
	  Local $usage = Number(StringMid($s, StringInStr($s, "GoldStorageL")+15, 2))
	  $usage = ($usage+$usageAdj>100 ? 100 : $usage+$usageAdj)
	  DebugWrite("Level " & $level & ", average " & $usage & "% full, confidence " & Round($conf*100, 2) & "%")
   EndIf

   ScanFrameForBestBMP("StorageUsageFrame.bmp", $ElixStorageBMPs, $gConfidenceStorages, $matchIndex, $conf, $x, $y)
   DebugWrite("Elix Match Index: " & $matchIndex)
   If $matchIndex <> -1 Then
	  Local $s = $ElixStorageBMPs[$matchIndex]
	  Local $level = Number(StringMid($s, StringInStr($s, "ElixStorageL")+12, 2))
	  Local $usage = Number(StringMid($s, StringInStr($s, "ElixStorageL")+15, 2))
	  $usage = ($usage+$usageAdj>100 ? 100 : $usage+$usageAdj)
	  DebugWrite("Level " & $level & ", average " & $usage & "% full, confidence " & Round($conf*100, 2) & "%")
   EndIf

   ScanFrameForBestBMP("StorageUsageFrame.bmp", $DarkStorageBMPs, $gConfidenceStorages, $matchIndex, $conf, $x, $y)
   DebugWrite("Dark Match Index: " & $matchIndex)
   If $matchIndex <> -1 Then
	  Local $s = $DarkStorageBMPs[$matchIndex]
	  Local $level = Number(StringMid($s, StringInStr($s, "DarkStorageL")+12, 1))
	  Local $usage = Number(StringMid($s, StringInStr($s, "DarkStorageL")+14, 2))
	  $usage = ($usage+$usageAdj>100 ? 100 : $usage+$usageAdj)
	  DebugWrite("Level " & $level & ", average " & $usage & "% full, confidence " & Round($conf*100, 2) & "%")
   EndIf
EndFunc

Func TestRaidTroopsCount()
   Local $troopIndex[$eTroopCount][5]
   FindRaidTroopSlotsAndCounts($gTroopSlotBMPs, $troopIndex)

   For $i=0 To $eTroopCount-1
	  If $troopIndex[$i][4]>0 Then DebugWrite("Available " & $gTroopNames[$i] & ": " & $troopIndex[$i][4])
   Next

   Local $spellIndex[$eSpellCount][5]
   FindRaidTroopSlotsAndCounts($gSpellSlotBMPs, $spellIndex)

   For $i=0 To $eSpellCount-1
	  If $spellIndex[$i][4]>0 Then DebugWrite("Available " & $gSpellNames[$i] & ": " & $spellIndex[$i][4])
   Next

EndFunc

Func TestBarracksStatus()
   Local $queueStatus = ScrapeFuzzyText($gBarracksCharacterMaps, $rBarracksWindowTextBox, $gBarracksCharMapsMaxWidth, $eScrapeDropSpaces)
   DebugWrite("Barracks queue status: " & $queueStatus)
EndFunc

Func TestDeployBoxCalcs()
   Local $box[19][4]
   Local $y = $gScreenCenterDraggedDown[1]-20
   Local $i = 0
   For $x = 45 To 405 Step 20
	  $box[$i][0] = $x
	  $box[$i][1] = $y
	  $box[$i][2] = $x+60
	  $box[$i][3] = $y+40
	  DebugWrite("NW Box: " & $i & " " & $box[$i][0] & "  " & $box[$i][1] & "  " & $box[$i][2] & "  " & $box[$i][3])
	  $i+=1
	  $y-=15
   Next

   $y = $gScreenCenterDraggedDown[1]-20
   $i=0
   For $x = 820 To 460 Step -20
	  $box[$i][0] = $x-60
	  $box[$i][1] = $y
	  $box[$i][2] = $x
	  $box[$i][3] = $y+40
	  DebugWrite("NE Box: " & $i & " " & $box[$i][0] & "  " & $box[$i][1] & "  " & $box[$i][2] & "  " & $box[$i][3])
	  $i+=1
	  $y-=15
   Next

   $y = $gScreenCenterDraggedUp[1]-20
   $i=0
   For $x = 45 To 405 Step 20
	  $box[$i][0] = $x
	  $box[$i][1] = $y
	  $box[$i][2] = $x+60
	  $box[$i][3] = $y+40
	  DebugWrite("SW Box: " & $i & " " & $box[$i][0] & "  " & $box[$i][1] & "  " & $box[$i][2] & "  " & $box[$i][3])
	  $i+=1
	  $y+=15
   Next

   $y = $gScreenCenterDraggedUp[1]-20
   $i=0
   For $x = 820 To 460 Step -20
	  $box[$i][0] = $x-60
	  $box[$i][1] = $y
	  $box[$i][2] = $x
	  $box[$i][3] = $y+40
	  DebugWrite("SE Box: " & $i & " " & $box[$i][0] & "  " & $box[$i][1] & "  " & $box[$i][2] & "  " & $box[$i][3])
	  $i+=1
	  $y+=15
   Next
EndFunc

Func TestDonate()
   If IsButtonPresent($rMainScreenOpenChatButton)=False Then OpenChatWindow()

   Local $donateButton[4]
   ;FindDonateButton($donateButton)

   $donateButton[0] = 33  - $rChatTextBoxAsOffset[0]
   $donateButton[1] = 242 - $rChatTextBoxAsOffset[1]
   $donateButton[2] = 285 - $rChatTextBoxAsOffset[2]
   $donateButton[3] = $donateButton[1]+10 - $rChatTextBoxAsOffset[3]

   Local $requestText
   GetRequestText($donateButton, $requestText)

   ;OpenDonateTroopsWindow($donateButton)

   ;Local $donateIndex[$eTroopCount][4]
   ;FindDonateTroopSlots($donateIndex)

   ;Local $indexOfTroopToDonate
   ;ParseRequestText($requestText, $donateIndex, $indexOfTroopToDonate)

   ;DebugWrite("Donate index: " & $indexOfTroopToDonate)
EndFunc

Func TestTownHall()
   Local $bestMatch, $bestConfidence, $left, $top

   GrabFrameToFile("TownHallTopFrame.bmp")
   ScanFrameForBestBMP("TownHallTopFrame.bmp", $TownHallBMPs, $gConfidenceTownHall, $bestMatch, $bestConfidence, $left, $top)

   DebugWrite("Likely TH Level " & $bestMatch+7 & " conf: " & $bestConfidence & @CRLF)

EndFunc

Func TestCollectors()
   Local $matchX[1], $matchY[1], $matchCount

   ; Grab frame
   GrabFrameToFile("LocateCollectorsFrame.bmp")

   $matchCount = LocateBuildings("All collectors", "LocateCollectorsFrame.bmp", $CollectorBMPs, $gConfidenceCollector, $matchX, $matchY)

   For $i = 0 To $matchCount-1
	  DebugWrite("Match " & $i & ": " & $matchX[$i] & "," & $matchY[$i])
   Next

EndFunc
